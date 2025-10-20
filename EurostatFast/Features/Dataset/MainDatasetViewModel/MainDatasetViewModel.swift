import Domain
import FactoryKit
import SwiftData
import SwiftUI


@Observable
final class MainDatasetViewModel {
    var state: State = .loading
}

// MARK: - View actions
extension MainDatasetViewModel {
    func onAppear() async {
        state = .empty
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
