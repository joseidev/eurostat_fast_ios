extension DatasetPageView {
    struct PresentationModel: Hashable {
        let index: Int
        let name: String
        let items: [DatasetItemView.PresentationModel]
    }
}
