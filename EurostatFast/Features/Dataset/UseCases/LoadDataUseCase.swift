import Domain
import FactoryKit


struct LoadDataUseCase {
    @Injected(\.metadataRepository) var metadataRepository
    @Injected(\.parameterRepository) var parameterRepository

    /// Loads metada and parameters
    func load() async throws -> ([Metadata], [Parameter]){
        async let metadata = metadataRepository.requestMetadata()
        async let parameters = parameterRepository.requestParameters()
        return (try await metadata, try await parameters)
    }
}
