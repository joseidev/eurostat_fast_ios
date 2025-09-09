import Foundation

extension DatasetItemView {
    struct PresentationModel: Identifiable, Hashable {
        let id: String
        let name: String
        let datasetChartModels: [DatasetChartView.PresentationModel]
    }
}

