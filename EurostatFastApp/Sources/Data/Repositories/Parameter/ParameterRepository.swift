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
        do {
            let dtos: [ParameterDTO] = try await memoryCache.get(path)
            return dtos.models
        } catch {
            let dtos: [ParameterDTO] = try await apiClient.request(.init(path: path))
            await memoryCache.set(path, dtos)
            return dtos.models
        }
    }
}

private extension [ParameterDTO] {
    var models: [Parameter] {
        map { $0.model }.sorted { $0.name < $1.name }
    }
}
