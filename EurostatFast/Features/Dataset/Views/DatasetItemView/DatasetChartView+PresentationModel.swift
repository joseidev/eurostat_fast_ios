import Foundation

extension DatasetChartView {
    struct PresentationModel: Identifiable, Hashable {
        let id: String
        let period: String
        let value: Double
        
        init(
            id: String = UUID().uuidString,
            period: String,
            value: Double
        ) {
            self.id = id
            self.period = period
            self.value = value
        }
    }
}
