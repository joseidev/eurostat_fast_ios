import Foundation

extension DatasetChartView {
    struct PresentationModel: Identifiable, Hashable {
        let id = UUID()
        let period: String
        let value: Double
    }
}
