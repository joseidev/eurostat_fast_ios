import Domain
import Foundation
import SwiftData

public struct DefaultMetadataRepository: MetadataRepository, @unchecked Sendable {
    private let apiClient: APIClient
    private let modelContext: ModelContext
    private let path = "datasets/metadata"
    
    public init(
        apiClient: APIClient,
        modelContext: ModelContext
    ) {
        self.apiClient = apiClient
        self.modelContext = modelContext
    }
    
    public func requestMetadata() async throws -> [Metadata] {
        do {
            let metadata = try getStoredMetadata()
            guard !metadata.isEmpty else {
                return try await apiRequestMetadata()
            }
            try? storeMetadata(metadata)
            return metadata
        } catch {
            return try await apiRequestMetadata()
        }
    }
    
    public func deleteAll() throws {
        try modelContext.delete(model: Metadata.self)
    }
}

private extension DefaultMetadataRepository {
    func apiRequestMetadata() async throws -> [Metadata] {
        let dtos: [MetadataDTO] = try await apiClient.request(.init(path: path))
        let metadata = dtos.models
        try? storeMetadata(metadata)
        return metadata
    }
    
    func storeMetadata(_ metadata: [Metadata]) throws {
        try metadata.forEach {
            modelContext.insert($0)
            try modelContext.save()
        }
    }
    
    func getStoredMetadata() throws -> [Metadata] {
        let metadata = FetchDescriptor<Metadata>()
        return try modelContext.fetch(metadata)        
    }
}

private extension [MetadataDTO] {
    var models: [Metadata] {
        map { $0.model }.sorted { $0.name < $1.name }
    }
}

