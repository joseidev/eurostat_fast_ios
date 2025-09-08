import SwiftUI

@Observable
final class MainDatasetViewModel {
    
}

// MARK: - View actions
extension MainDatasetViewModel {
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
