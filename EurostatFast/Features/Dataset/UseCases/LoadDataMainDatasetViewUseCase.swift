import Domain
import FactoryKit

struct LoadDataMainDatasetViewUseCase {
    @Injected(\.datasetPageRepository) var datasetPageRepository
    @Injected(\.datasetPageViewPresentationModelRepository) var datasetPageViewPresentationModelRepository
    func loadData() throws -> [DatasetPageView.PresentationModel] {
//        try datasetPageRepository.deleteAll()
//        try datasetPageViewPresentationModelRepository.deleteAll()
        let aa = try datasetPageRepository.getModels()
        let bb = try datasetPageViewPresentationModelRepository.getModels()
        return bb
    }
}

