import Foundation

struct ChartData: Identifiable {
    let id = UUID()
    let period: String
    let value: Double
}
