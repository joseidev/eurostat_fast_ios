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

extension DatasetPageViewPresentationModel {
    var presentationModel: DatasetPageView.PresentationModel {
        .init(
            datasetPageId: self.datasetPageID,
            pageIndex: self.pageIndex,
            name: self.name,
            items: self.items.map { $0.presentationModel }
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

extension DatasetPageItem {
    var presentationModel: DatasetItemView.PresentationModel {
        .init(
            id: self.id,
            name: self.name,
            datasetChartModels: self.datasetChartModels.map { $0.presentationModel }
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

extension DatasetChartModel {
    var presentationModel: DatasetChartView.PresentationModel {
        .init(
            id: self.id,
            period: self.period,
            value: self.value
        )
    }
}
