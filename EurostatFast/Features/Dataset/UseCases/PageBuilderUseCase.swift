import Domain

struct PageBuilderUseCase {
    func build(
        _ model: EditPageViewModel.SavedModel,
        _ metadata: [Metadata],
        _ geoParameter: Parameter
    ) -> DatasetPageView.PresentationModel {
        switch model {
        case let .geo(geoModel):
            buildGeo(geoModel, metadata, geoParameter)
        }
    }
}

private extension PageBuilderUseCase {
    func buildGeo(
        _ model: EditPageViewModel.SavedModel.Geo,
        _ metadata: [Metadata],
        _ geoParameter: Parameter
    ) -> DatasetPageView.PresentationModel {
        pageMock2
    }
}

private let pageMock2: DatasetPageView.PresentationModel = .init(
    index: 0,
    name: "Use case",
    items: [.init(id: "01", name: "Nombre2", datasetChartModels: dataMock)]
)

private let dataMock2: [DatasetChartView.PresentationModel] = [
    .init(period: "2022-Q3", value: 2.9),
    .init(period: "2022-Q4", value: 2.1),
    .init(period: "2023-Q1", value: 1.3),
    .init(period: "2023-Q2", value: 0.6),
    .init(period: "2023-Q3", value: 0.1),
    .init(period: "2023-Q4", value: 0.2),
    .init(period: "2024-Q1", value: 0.5),
    .init(period: "2024-Q2", value: 0.5),
    .init(period: "2024-Q3", value: 0.9),
    .init(period: "2024-Q4", value: 1.3),
    .init(period: "2025-Q1", value: 1.6),
    .init(period: "2025-Q2", value: 1.5)
]
