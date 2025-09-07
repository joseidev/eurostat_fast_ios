import Domain
import Foundation

public struct DefaultParameterRepository: ParameterRepository {
    private let apiClient: APIClient
    private let memoryCache: MemoryCache
    private let path = "parameter"
    
    public init(
        apiClient: APIClient,
        memoryCache: MemoryCache
    ) {
        self.apiClient = apiClient
        self.memoryCache = memoryCache
    }
    
    public func requestParameters() async throws -> [Parameter] {
        if let dtos: [ParameterDTO] = memoryCache.get(path) {
            return dtos.map { $0.model }.sorted { $0.name < $1.name }
        }
        let dtos: [ParameterDTO] = try await apiClient.request(.init(path: path))
        memoryCache.set(path, dtos)
        return dtos.map { $0.model }.sorted { $0.name < $1.name }
    }
}

