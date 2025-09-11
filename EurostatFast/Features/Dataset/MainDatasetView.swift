import SwiftUI
import UI

struct MainDatasetView: View {
    @State var viewModel: MainDatasetViewModel = .init()
    @State var isEditPageViewPresented: Bool = false
    @State var isAddPageViewPresented: Bool = false
    @State var selectedPageIndex = 0
    var body: some View {
        VStack {
            DatasetHeaderView(
                editAction: { isEditPageViewPresented = true },
                addAction: { isAddPageViewPresented = true },
                deleteAction: { viewModel.onTapDeletePage(selectedPageIndex) }
            )
            .padding()
            switch viewModel.state {
                case .loading:
                LoadingStateView()
            case .empty:
                EmptyStateView()
            case let .loaded(pages):
                DataSetPageScrollView(selectedPageIndex: $selectedPageIndex) {
                    ForEach(pages, id: \.self) { page in
                        DatasetPageView(presentationModel: page)
                            .tag(page.index)
                    }
                }
            }
        }
        .background(Color.Background.default)
        .task {
            await viewModel.onAppear()
        }
        .fullScreenCover(isPresented: $isEditPageViewPresented) {
            EditPageView(
                isNewPage: false,
                closeAction: {
                    isEditPageViewPresented = false
                },
                saveAction: {
                    
                },
                selectAction: viewModel.onSelectAction
            )
        }
        .fullScreenCover(isPresented: $isAddPageViewPresented) {
            EditPageView(
                isNewPage: true,
                closeAction: {
                    isAddPageViewPresented = false
                },
                saveAction: {
                    
                },
                selectAction: viewModel.onSelectAction
            )
        }
    }
}

private struct LoadingStateView: View {
    var body: some View {
        VStack {
            Text("Loading data...")
                .italic()
                .padding(.top, 64)
            ProgressView()
            Spacer()
        }
    }
}

private struct EmptyStateView: View {
    var body: some View {
        VStack {
            Text("Add a new page to start.")
                .padding(.top, 64)
            Spacer()
        }
    }
}
