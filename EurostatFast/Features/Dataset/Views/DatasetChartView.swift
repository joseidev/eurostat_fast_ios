import Charts
import SwiftUI

struct DatasetChartView: View {
    let data: [ChartData]
    @State private var selectedPeriod: String?
    
    var body: some View {
        VStack {
            HStack {
                Text(selectedPeriod ?? "")
                    .font(.caption2)
                    .frame(minHeight: 20)
                Text(getValueFromPeriod(selectedPeriod))
                    .font(.caption2)
                    .frame(minHeight: 20)
                Spacer()
            }
            .padding(.leading, 12)
            Chart(data) { point in
                LineMark(
                    x: .value("Periodo", point.period),
                    y: .value("Valor", point.value)
                )
                .foregroundStyle(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.blue.opacity(0.5),
                            Color.blue.opacity(0.7),
                            Color.blue.opacity(0.9)
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                PointMark(
                    x: .value("Periodo", point.period),
                    y: .value("Valor", point.value)
                )
                .symbolSize(16)
                .foregroundStyle(.clear)
            }
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            .chartXSelection(value: $selectedPeriod)
            .frame(height: 50)
        }
    }
    
    func getValueFromPeriod(_ period: String?) -> String {
        guard let data = data.first(where: {$0.period == period}) else {
            return ""
        }
        return String(data.value)
    }
}
