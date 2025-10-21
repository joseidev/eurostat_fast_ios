extension DatasetPageView {
    struct PresentationModel: Hashable {
        let datasetPageId: String
        let pageIndex: Int
        let name: String
        let items: [DatasetItemView.PresentationModel]
    }
}



