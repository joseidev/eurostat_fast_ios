import Charts
import SwiftUI

struct ChartContainerView: View {
    let data: [ChartData]
    @Binding var selectedPeriod: String?
    
    var body: some View {
        Chart(data) { point in
            LineMark(
                x: .value("", point.period),
                y: .value("", point.value)
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
                x: .value("", point.period),
                y: .value("", point.value)
            )
            .symbolSize(16)
            .foregroundStyle(.clear)
            AreaMark(
                x: .value("", point.period),
                y: .value("", point.value)
            )
            .foregroundStyle(
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.4), Color.blue.opacity(0.05)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .chartXSelection(value: $selectedPeriod)
        .frame(height: 50)
        .padding(.horizontal, -16)
    }
}
