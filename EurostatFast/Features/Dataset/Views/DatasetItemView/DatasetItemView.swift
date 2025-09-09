import SwiftUI

struct DatasetItemView: View {
    let presentationModel: PresentationModel
    @State private var selectedPeriod: String?
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(presentationModel.name)
                    .font(.system(size: 16, weight: .bold))
                Spacer()
                VStack(alignment: .trailing) {
                    Text(getValueFromSelectedPeriod())
                        .font(.system(size: 24, weight: .bold))
                    Text(getPeriodFromSelectedPeriod())
                        .font(.system(.caption))
                        .monospacedDigit()
                        .foregroundStyle(.black.opacity(0.6))

                }
            }
            DatasetChartView(
                models: presentationModel.datasetChartModels,
                selectedPeriod: $selectedPeriod
            )
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 6)
                .fill(.white)
        }
        .padding(.top, 8)
    }
    
    func getValueFromSelectedPeriod() -> String {
        guard let data = presentationModel.datasetChartModels.first(where: {$0.period == selectedPeriod}) else {
            guard let value = presentationModel.datasetChartModels.last?.value else {
                return ""
            }
            return String(value) + " %"
        }
        return String(data.value) + " %"
    }
    
    func getPeriodFromSelectedPeriod() -> String {
        guard let selectedPeriod else {
            return presentationModel.datasetChartModels.last?.period ?? ""
        }
        return selectedPeriod
    }
}
