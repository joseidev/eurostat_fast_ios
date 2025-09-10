import Domain
import Foundation

public struct DefaultDatasetDataRepository: DatasetDataRepository {
    private let apiClient: APIClient
    private let memoryCache: MemoryCache
    private let path = "datasets/data/"
    
    public init(
        apiClient: APIClient,
        memoryCache: MemoryCache
    ) {
        self.apiClient = apiClient
        self.memoryCache = memoryCache
    }
    
    public func requestDatasetData(_ code: String, _ geoValues: [String]) async throws -> DatasetData {
        let memoryCacheKey = DataHelpers.buildMemoryCacheKey(path, code, geoValues)
        do {
            let dto: DatasetDataDTO = try await memoryCache.get(memoryCacheKey)
            return dto.model
        } catch {
            let path = path + "\(code)"
            let endpoint = Endpoint(path: path, queryItems: geoValues.geoQueryItems)
            let dto: DatasetDataDTO = try await apiClient.request(endpoint)
            await memoryCache.set(memoryCacheKey, dto)
            return dto.model
        }
    }
}
