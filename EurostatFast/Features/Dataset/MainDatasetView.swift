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
            DataSetPageScrollView {
                DatasetPageView()
                DatasetPageView()
                DatasetPageView()
            }
        }
        .padding()
    }
}
