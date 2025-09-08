import SwiftUI

struct MainDatasetView: View {
    var body: some View {
        VStack {
            DatasetHeaderView(editAction: {}, addAction: {}, deleteAction: {})
            DataSetPageScrollView {
                DatasetPageView()
                DatasetPageView()
                DatasetPageView()
            }
        }
        .padding()
    }
}


