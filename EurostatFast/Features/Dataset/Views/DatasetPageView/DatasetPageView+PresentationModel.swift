extension DatasetPageView {
    struct PresentationModel: Hashable {
        let name: String
        let items: [DatasetItemView.PresentationModel]
    }
}
