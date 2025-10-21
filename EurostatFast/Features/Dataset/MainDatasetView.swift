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
                deleteAction: { viewModel.onTapDeletePage() }
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
                            .tag(page.pageIndex)
                    }
                }
            }
        }
        .background(Color.Background.default)
        .task {
            await viewModel.onAppear()
        }
        .fullScreenCover(isPresented: $isEditPageViewPresented) {
            EditPageView(viewModel: .init(
                isNewPage: false,
                onClose: {
                    isEditPageViewPresented = false
                },
                onSave: { _ in }
            ))
        }
        .fullScreenCover(isPresented: $isAddPageViewPresented) {
            EditPageView(viewModel: .init(
                isNewPage: true,
                onClose: {
                    isAddPageViewPresented = false
                },
                onSave: { savedModel in
                    Task {                        
                        await viewModel.onSaveNewPage(savedModel)
                        isAddPageViewPresented = false
                    }
                }
            ))
        }
        .alert(isPresented: $viewModel.isConfirmDeletePageVisible) {
            Alert(
                title: Text("Delete page"),
                message: Text("Do you want to delete this page?"),
                primaryButton: .default(
                    Text("Cancel"),
                    action: {
                        viewModel.isConfirmDeletePageVisible = false
                    }
                ),
                secondaryButton: .destructive(
                    Text("Delete"),
                    action: {
                        viewModel.onConfirmDeletePage(selectedPageIndex)
                    }
                )
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
