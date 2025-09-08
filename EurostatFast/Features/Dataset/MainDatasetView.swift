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
                DatasetPageView()
                DatasetPageView()
                DatasetPageView()
            }
        }
        .background(.black.opacity(0.05))        
    }
}
