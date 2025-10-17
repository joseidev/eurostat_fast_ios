import SwiftUI

@Observable
final class EditPageViewModel {
    let isNewPage: Bool
    let onClose: () -> Void
    var presentationModel: PresentationModel = .initial
    
    init(isNewPage: Bool, onClose: @escaping () -> Void) {
        self.isNewPage = isNewPage
        self.onClose = onClose
    }
}

// View methods

extension EditPageViewModel {
    func onAppear() {
        presentationModel = .init(
            primaryItemName: "Geo items",
            selectedPageType: .geo,
            selectedPrimaryItem: .init(id: "2", name: "Spain"),
            primarySelectorItems: aaMock,
            datasetListItems: itemsMock
        )
    }
    
    func onTapClose() {
        onClose()
    }
    
    func onTapSave() {
        // Create new Page model based on selection
    }
    
    func onSelectListItem(_ id: String) {
        presentationModel.updateDatasetListItem(id)
    }
    
    func onSelectPageType(_ pageType: PageType) {
        // Update presentation model
    }
}

extension EditPageViewModel {
    struct PresentationModel {
        var primaryItemName: String
        var selectedPageType: PageType
        var selectedPrimaryItem: EditPageSelectorView.Item
        var primarySelectorItems: [EditPageSelectorView.Item]
        var datasetListItems: [DatasetListView.Item]
        
        static let initial: Self = .init(
            primaryItemName: "",
            selectedPageType: .geo,
            selectedPrimaryItem: .init(id: "", name: ""),
            primarySelectorItems: [],
            datasetListItems: []
        )
        
        mutating func updateDatasetListItem(_ id: String) {
            guard let index = datasetListItems.firstIndex(where: {$0.id == id}) else {
                return
            }
            datasetListItems[index].isSelected.toggle()
        }
    }
}

let aaMock: [EditPageSelectorView.Item] = [
    .init(id: "1", name: "EU"),
    .init(id: "2", name: "Spain"),
    .init(id: "3", name: "Italy"),
]


let itemsMock: [DatasetListView.Item] =
    [
        .init(id: UUID().uuidString, name: "Dataset 1", isSelected: false),
        .init(id: UUID().uuidString, name: "Dataset 2", isSelected: true),
        .init(id: UUID().uuidString, name: "Dataset 3", isSelected: false),
        .init(id: UUID().uuidString, name: "Dataset 4", isSelected: true),
        .init(id: UUID().uuidString, name: "Dataset 5", isSelected: false),
    ]
