import SwiftData
import Foundation
import Domain

public struct DefaultDatasetPageRepository: @unchecked Sendable  {
    private let modelContext: ModelContext
    
    public init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
}

extension DefaultDatasetPageRepository: DatasetPageRepository {
    public func store(_ datasetPage: DatasetPage) throws {
        modelContext.insert(datasetPage)
        try modelContext.save()
    }
    
    public func getModels() throws -> [DatasetPage] {
        let datasetPages = FetchDescriptor<DatasetPage>(
            sortBy: [
                .init(\.pageIndex)
            ]
        )
        return try modelContext.fetch(datasetPages)
    }
    
    public func getLastPageIndex() throws -> Int? {
        let datasetPages = FetchDescriptor<DatasetPage>(
            sortBy: [
                .init(\.pageIndex)
            ]
        )
        return try modelContext.fetch(datasetPages).last?.pageIndex
    }

    public func update(
        id: String,
        pageIndex: Int,
        geoCode: String,
        datasetCodes: [String]
    ) throws {
        let descriptor = FetchDescriptor<DatasetPage>(
            predicate: #Predicate { $0.id == id }
        )
        if let page = try modelContext.fetch(descriptor).first {
            page.pageIndex = pageIndex
            page.geoCode = geoCode
            page.datasetCodes = datasetCodes
            try modelContext.save()
        }
    }
    
    public func delete(_ id: String) throws {
        let descriptor = FetchDescriptor<DatasetPage>(
            predicate: #Predicate { $0.id == id }
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
