import SwiftData
import Foundation
import Domain

public struct DefaultDatasetPageViewPresentationModelRepository: @unchecked Sendable {
    private let modelContext: ModelContext
    
    public init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
}

extension DefaultDatasetPageViewPresentationModelRepository: DatasetPageViewPresentationModelRepository {
    public func store(_ model: DatasetPageViewPresentationModel) throws {
        modelContext.insert(model)
        try modelContext.save()

    }
    
    public func getModels() throws -> [DatasetPageViewPresentationModel] {
        let models = FetchDescriptor<DatasetPageViewPresentationModel>(
            sortBy: [
                .init(\.pageIndex)
            ]
        )
        return try modelContext.fetch(models)
    }
    
    public func delete(_ id: String) throws {
        let descriptor = FetchDescriptor<DatasetPageViewPresentationModel>(
            predicate: #Predicate { $0.datasetPageID == id }
        )
        guard let model = try modelContext.fetch(descriptor).first else {
            throw APIError.notFoundInCache
        }
        modelContext.delete(model)
    }
    
    public func deleteAll() throws {
        try modelContext.delete(model: DatasetPage.self)
    }
}
