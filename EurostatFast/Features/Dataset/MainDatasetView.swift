import SwiftUI
import UI

struct MainDatasetView: View {
    @State var viewModel: MainDatasetViewModel = .init()
    var body: some View {
        VStack {
            DatasetHeaderView(
                editAction: viewModel.didTapEditPage,
                addAction: viewModel.didTapAddNewPage,
                deleteAction: viewModel.didTapDeletePage
            )
            .padding()
            switch viewModel.state {
                case .loading:
                LoadingStateView()
            case .empty:
                EmptyStateView()
            case let .loaded(pages):
                DataSetPageScrollView {
                    ForEach(pages, id: \.self) { page in
                        DatasetPageView(presentationModel: page)
                    }
                }
            }
        }
        .background(Color.Background.default)
        .task {
            await viewModel.onAppear()
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
