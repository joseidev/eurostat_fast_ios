import Domain
import FactoryKit
import SwiftData
import SwiftUI


@Observable
final class MainDatasetViewModel {
    @ObservationIgnored
    @Injected(\.loadDataMainDatasetViewUseCase) var loadDataMainDatasetViewUseCase
    var state: State = .loading
    private var models: [DatasetPageView.PresentationModel] = []
}

// MARK: - View actions
extension MainDatasetViewModel {
    func onAppear() async {
        do {
            let models = try loadDataMainDatasetViewUseCase.loadData()
            if models.isEmpty {
                state = .empty
                return
            }
            self.models = models
            state = .loaded(models)
        } catch {
            
        }
    }

    func onTapDeletePage(_ selectedPageIndex: Int) {
        print("didTapDeletePage", selectedPageIndex)
    }

    @MainActor
    func onSaveNewPage(_ savedModel: DatasetPageView.PresentationModel) async {
        self.models.append(savedModel)
        state = .loaded(self.models)
    }
}

private extension MainDatasetViewModel {

}
