import Domain
import FactoryKit
import Foundation

struct PageBuilderUseCase {
    @Injected(\.datasetDataRepository) var datasetDataRepository
    
    func build(
        _ model: EditPageViewModel.SavedModel,
        _ metadata: [Metadata],
        _ geoParameter: Parameter
    ) async throws -> DatasetPageView.PresentationModel {
        switch model {
        case let .geo(geoModel):
            try await buildGeo(geoModel, metadata, geoParameter)
        }
    }
}

private extension PageBuilderUseCase {
    func buildGeo(
        _ model: EditPageViewModel.SavedModel.Geo,
        _ metadata: [Metadata],
        _ geoParameter: Parameter
    ) async throws -> DatasetPageView.PresentationModel {
        .init(
            index: 0,
            name: geoParameter.getName(model.geoCode),
            items: try await getItems(model.datasetCodes, model.geoCode)
        )
    }
    
    func getItems(_ datasetCodes: [String], _ geoCode: String) async throws -> [DatasetItemView.PresentationModel] {
        var models: [DatasetItemView.PresentationModel] = []
        for datasetCode in datasetCodes {
            let model = try await getDatasetModel(datasetCode, "Name", geoCode)
            models.append(model)
        }
        return models
    }
    
    func getDatasetModel(_ datasetCode: String, _ name: String, _ geoCode: String) async throws -> DatasetItemView.PresentationModel {
        let values = try await datasetDataRepository.requestDatasetData(datasetCode, [geoCode])
        guard let values = values.data.first(where: {$0.geo == geoCode})?.values else {
            throw AppError.dataNotFound
        }
        let datasetChartModels = values.getDatasetChartViewItems().sorted(by: {$0.period < $1.period})
        return .init(id: UUID().uuidString, name: name, datasetChartModels: datasetChartModels)
    }
}


private extension Parameter {
    func getName(_ geoCode: String) -> String {
        values.first(where: {$0.code == geoCode})?.description ?? ""
    }
}

private extension [String: Double] {
    /// Returns model for chart from dataset values
    func getDatasetChartViewItems() -> [DatasetChartView.PresentationModel] {
        map {DatasetChartView.PresentationModel(period: $0.key, value: $0.value)}
    }
}
