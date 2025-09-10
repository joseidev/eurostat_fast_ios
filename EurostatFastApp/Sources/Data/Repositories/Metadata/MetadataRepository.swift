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
        do {
            let dtos: [MetadataDTO] = try await memoryCache.get(path)
            return dtos.models
        } catch {
            let dtos: [MetadataDTO] = try await apiClient.request(.init(path: path))
            await memoryCache.set(path, dtos)
            return dtos.models
        }
    }
}

private extension [MetadataDTO] {
    var models: [Metadata] {
        map { $0.model }.sorted { $0.name < $1.name }
    }
}

