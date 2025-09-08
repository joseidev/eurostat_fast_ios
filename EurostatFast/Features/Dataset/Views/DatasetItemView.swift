import SwiftUI

struct DatasetItemView: View {
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("Total unemployment rate")
                        .font(.system(size: 12, weight: .bold))
                    Text("2025-Q2")
                        .font(.system(size: 8))
                        .foregroundStyle(.black.opacity(0.6))
                }
                Spacer()
                Text("13.5 %")
                    .font(.system(size: 24, weight: .bold))
            }
            DatasetChartView(data: data)
                .padding(.top, 6)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 6)
                .fill(.white)
        }
    }
}

let data: [ChartData] = [
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
