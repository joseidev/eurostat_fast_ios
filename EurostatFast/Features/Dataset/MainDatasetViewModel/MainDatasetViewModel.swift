import SwiftUI

@Observable
final class MainDatasetViewModel {
    var state: State = .loading
}

// MARK: - View actions
extension MainDatasetViewModel {
    func onAppear() async {
//        state = .loaded([pageMock])
    }
    func didTapAddNewPage() {
        print("didTapAddNewPage")
    }
    func didTapEditPage() {
        print("didTapEditPage")
    }
    func didTapDeletePage() {
        print("didTapDeletePage")
    }
}

let pageMock: DatasetPageView.PresentationModel = .init(name: "España", items: [.init(id: "01", name: "Nombre", datasetChartModels: dataMock)])

let dataMock: [DatasetChartView.PresentationModel] = [
    .init(period: "2022-Q3", value: 2.9),
    .init(period: "2022-Q4", value: 2.1),
    .init(period: "2023-Q1", value: 1.3),
    .init(period: "2023-Q2", value: 0.6),
    .init(period: "2023-Q3", value: 0.1),
    .init(period: "2023-Q4", value: 0.2),
    .init(period: "2024-Q1", value: 0.5),
    .init(period: "2024-Q2", value: 0.5),
    .init(period: "2024-Q3", value: 0.9),
    .init(period: "2024-Q4", value: 1.3),
    .init(period: "2025-Q1", value: 1.6),
    .init(period: "2025-Q2", value: 1.5)
]
