import Foundation

struct ChartData: Identifiable, Hashable {
    let id = UUID()
    let period: String
    let value: Double
}

let dataMock: [ChartData] = [
    ChartData(period: "2022-Q3", value: 2.9),
    ChartData(period: "2022-Q4", value: 2.1),
    ChartData(period: "2023-Q1", value: 1.3),
    ChartData(period: "2023-Q2", value: 0.6),
    ChartData(period: "2023-Q3", value: 0.1),
    ChartData(period: "2023-Q4", value: 0.2),
    ChartData(period: "2024-Q1", value: 0.5),
    ChartData(period: "2024-Q2", value: 0.5),
    ChartData(period: "2024-Q3", value: 0.9),
    ChartData(period: "2024-Q4", value: 1.3),
    ChartData(period: "2025-Q1", value: 1.6),
    ChartData(period: "2025-Q2", value: 1.5)
]
