import Domain
import Foundation

public struct DefaultMetadataRepository: MetadataRepository {
    private let apiClient: APIClient
    private let path = "datasets/metadata"
    
    public init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    public func requestMetadata() async throws -> [Metadata] {
        let dtos: [MetadataDTO] = try await apiClient.request(.init(path: path))
        return dtos.map { $0.model }.sorted { $0.name < $1.name }
    }
}

