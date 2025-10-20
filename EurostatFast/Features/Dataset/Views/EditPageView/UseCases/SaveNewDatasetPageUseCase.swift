import Data
import Domain
import FactoryKit

struct SaveNewDatasetPageUseCase {
    @Injected(\.pageBuilderUseCase) var pageBuilderUseCase
    @Injected(\.datasetPageRepository) var datasetPageRepository
    @Injected(\.parameterRepository) var parameterRepository
    @Injected(\.metadataRepository) var metadataRepository
    
    func saveNewPage(
        _ savedModel: EditPageViewModel.SavedModel
    ) async throws  -> DatasetPageView.PresentationModel {
        switch savedModel {
            case let  .geo(geoModel):
                try await saveGeoModel(geoModel)
        }
    }
}

private extension SaveNewDatasetPageUseCase {
    func saveGeoModel(_ geoModel: EditPageViewModel.SavedModel.Geo) async throws -> DatasetPageView.PresentationModel {
        let metadata = try await metadataRepository.requestMetadata()
        guard let geoParameter = try await parameterRepository.getGeoParameter() else {
            throw AppError.dataNotFound
        }
        let lastPageIndex = try datasetPageRepository.getLastPageIndex() ?? -1
        let pageIndex = lastPageIndex + 1
        try datasetPageRepository.store(geoModel.buildNewDatasetPage(pageIndex))
        return try await pageBuilderUseCase.buildGeoModel(
            pageIndex,
            geoModel,
            metadata,
            geoParameter
        )
    }
}

private extension EditPageViewModel.SavedModel.Geo {
    func buildNewDatasetPage(_ index: Int) -> DatasetPage {
        .init(
            pageIndex: index,
            geoCode: self.geoCode,
            datasetCodes: self.datasetCodes
        )
    }
}
