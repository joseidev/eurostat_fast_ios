import Domain
import Foundation
import SwiftData

public struct DefaultParameterRepository: ParameterRepository, @unchecked Sendable {
    private let apiClient: APIClient
    private let modelContext: ModelContext
    private let path = "parameter"
    
    public init(
        apiClient: APIClient,
        modelContext: ModelContext
    ) {
        self.apiClient = apiClient
        self.modelContext = modelContext
    }
    
    public func requestParameters() async throws -> [Parameter] {
        do {
            let parameters = try getStoredParameters()
            guard !parameters.isEmpty else {
                return try await apiRequestParameters()
            }
            return parameters
        } catch {
            return try await apiRequestParameters()
        }
    }
    
    public func getGeoParameter() async throws -> Parameter? {
        let parameters = try await requestParameters()
        return parameters.geoParameter
    }
    
    public func deleteAll() throws {
        try modelContext.delete(model: Parameter.self)
    }
}

private extension DefaultParameterRepository {
    func apiRequestParameters() async throws -> [Parameter] {
        let dtos: [ParameterDTO] = try await apiClient.request(.init(path: path))
        let parameters = dtos.models
        try? storeParameters(parameters)
        return parameters
    }
    
    func storeParameters(_ parameter: [Parameter]) throws {
        try parameter.forEach {
            modelContext.insert($0)
            try modelContext.save()
        }
    }
    
    func getStoredParameters() throws -> [Parameter] {
        let parameters = FetchDescriptor<Parameter>()
        return try modelContext.fetch(parameters)
    }
}

private extension [ParameterDTO] {
    var models: [Parameter] {
        map { $0.model }.sorted { $0.name < $1.name }
    }
}
