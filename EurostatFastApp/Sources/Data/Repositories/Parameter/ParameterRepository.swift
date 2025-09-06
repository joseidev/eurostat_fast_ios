import Domain
import Foundation

public struct DefaultParameterRepository: ParameterRepository {
    private let apiClient: APIClient
    private let path = "parameter"
    
    public init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    public func requestParameters() async throws -> [Parameter] {
        let dtos: [ParameterDTO] = try await apiClient.request(.init(path: path))
        return dtos.map { $0.model }.sorted { $0.name < $1.name }
    }
}

