import Domain

extension EditPageView {
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
        
        var geoModel: EditPageViewModel.SavedModel? {
            guard selectedPageType == .geo else {
                return nil
            }
            let model = EditPageViewModel.SavedModel.Geo(
                geoCode: selectedPrimaryItem.id,
                datasetCodes: datasetListItems.filter { $0.isSelected }.map { $0.id }
            )
            return .geo(model)
        }
    }
}
