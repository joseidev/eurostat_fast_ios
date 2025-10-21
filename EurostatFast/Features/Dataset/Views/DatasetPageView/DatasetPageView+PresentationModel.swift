import Domain

extension DatasetPageView {
    struct PresentationModel: Hashable {
        let datasetPageId: String
        let pageIndex: Int
        let name: String
        let items: [DatasetItemView.PresentationModel]
    }
}

extension DatasetPageView.PresentationModel {
    var persistedModel: DatasetPageViewPresentationModel {
        .init(
            datasetPageID: self.datasetPageId,
            pageIndex: self.pageIndex,
            name: self.name,
            items: self.items.map{ $0.persistedModel }
        )
    }
}

extension DatasetItemView.PresentationModel {
    var persistedModel: DatasetPageItem {
        .init(
            id: self.id,
            name: self.name,
            datasetChartModels: self.datasetChartModels.map { $0.persistedModel }
        )
    }
}

extension DatasetChartView.PresentationModel {
    var persistedModel: DatasetChartModel {
        .init(
            id: self.id,
            period: self.period,
            value: self.value
        )
    }
}
