import Domain
import FactoryKit

struct LoadDataMainDatasetViewUseCase {
    @Injected(\.datasetPageRepository) var datasetPageRepository
    @Injected(\.datasetPageViewPresentationModelRepository) var datasetPageViewPresentationModelRepository
    func loadData() throws -> [DatasetPageView.PresentationModel] {
        //TODO: Handle when cache is deleted when expired
        let datasetPages = try datasetPageRepository.getModels()
        let presentationModels = try datasetPageViewPresentationModelRepository.getModels()
        return presentationModels
            .map { $0.presentationModel }
            .sorted { $0.pageIndex < $1.pageIndex }
    }
}

private extension LoadDataMainDatasetViewUseCase {
    func deleteoModels() throws {
        try datasetPageRepository.deleteAll()
        try datasetPageViewPresentationModelRepository.deleteAll()
    }
}
