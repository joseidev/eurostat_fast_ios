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
    
    public func delete(_ model: DatasetPageViewPresentationModel) {
        modelContext.delete(model)
    }
    
    public func deleteAll() throws {
        try modelContext.delete(model: DatasetPage.self)
    }
}
