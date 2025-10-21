import Domain
import FactoryKit
import SwiftData
import SwiftUI


@Observable
final class MainDatasetViewModel {
    @ObservationIgnored
    @Injected(\.loadDataMainDatasetViewUseCase) var loadDataMainDatasetViewUseCase
    var state: State = .loading
}

// MARK: - View actions
extension MainDatasetViewModel {
    func onAppear() async {
        let models = loadDataMainDatasetViewUseCase.loadData()
        if models.isEmpty {
            state = .empty
            return
        }
        state = .loaded(models)
    }

    func onTapDeletePage(_ selectedPageIndex: Int) {
        print("didTapDeletePage", selectedPageIndex)
    }

    @MainActor
    func onSaveNewPage(_ savedModel: DatasetPageView.PresentationModel) async {
        state = .loaded([savedModel])
    }
}

private extension MainDatasetViewModel {

}
