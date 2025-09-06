import Domain
import Foundation

public struct DefaultMetadataRepository {
    private let apiClient: APIClient = DefaultAPIClient()
    private let path = "datasets/metadata"
    
    public init() {}
    
    
    public func requestMetadata() async throws -> Metadata {
        let dto: MetadataDTO = try await apiClient.request(.init(path: path))
        return dto.model
    }
}

