import Foundation

extension DatasetChartView {
    struct PresentationModel: Identifiable, Hashable {
        let id: String = UUID().uuidString
        let period: String
        let value: Double
    }
}
