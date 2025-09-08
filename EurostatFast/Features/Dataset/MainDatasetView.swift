import SwiftUI

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
            DataSetPageScrollView {
                ForEach(viewModel.pages, id: \.self) { page in
                    DatasetPageView(presentationModel: page)
                }
            }
        }
        .background(.black.opacity(0.05))
        .task {
            await viewModel.onAppear()
        }
    }
}
