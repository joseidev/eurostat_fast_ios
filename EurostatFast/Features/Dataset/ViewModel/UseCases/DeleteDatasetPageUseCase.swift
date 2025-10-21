import Domain
import FactoryKit

struct DeleteDatasetPageUseCase {
    @Injected(\.datasetPageRepository) var datasetPageRepository
    @Injected(\.datasetPageViewPresentationModelRepository) var datasetPageViewPresentationModelRepository
    
    func delete(_ id: String) throws {
        try datasetPageRepository.delete(id)
        try datasetPageViewPresentationModelRepository.delete(id)        
    }
}

