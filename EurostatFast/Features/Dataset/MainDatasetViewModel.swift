import SwiftUI

@Observable
final class MainDatasetViewModel {
    var pages: [DatasetPageView.PresentationModel] = []
}

// MARK: - View actions
extension MainDatasetViewModel {
    func onAppear() async {
        pages = [.init(name: "España", items: [.init(id: "01", name: "Nombre", data: dataMock)])]
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
