import Domain
import Foundation

public struct DefaultMetadataRepository: MetadataRepository {
    private let apiClient: APIClient
    private let memoryCache: MemoryCache
    private let path = "datasets/metadata"
    
    public init(
        apiClient: APIClient,
        memoryCache: MemoryCache
    ) {
        self.apiClient = apiClient
        self.memoryCache = memoryCache
    }
    
    public func requestMetadata() async throws -> [Metadata] {
        if let dtos: [MetadataDTO] = memoryCache.get(path) {
            return dtos.map { $0.model }.sorted { $0.name < $1.name }
        }
        let dtos: [MetadataDTO] = try await apiClient.request(.init(path: path))
        memoryCache.set(path, dtos)
        return dtos.map { $0.model }.sorted { $0.name < $1.name }
    }
}

