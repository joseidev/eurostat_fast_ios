import Data
import Domain
import FactoryKit
import Foundation
import SwiftData

extension Container {
    var apliClient: Factory<APIClient> {
        self { DefaultAPIClient() }
    }
    
    var persitenceDataStore: Factory<PersistenceDataStore> {
        self {
            do {
                return try DefaultPersistenceDataStore.makeDefault()
            } catch {
                fatalError("❌ Error al crear PersistenceDataStore: \(error)")
            }
        }.singleton
    }
    
    var memoryCache: Factory<MemoryCache> {
        self { DefaultMemoryCache() }.singleton
    }
    
    var metadataRepository: Factory<MetadataRepository> {
        self { @MainActor in DefaultMetadataRepository(
            apiClient: self.apliClient(),
            memoryCache: self.memoryCache()
        ) }
    }
    
    var parameterRepository: Factory<ParameterRepository> {
        self { @MainActor in DefaultParameterRepository(
            apiClient: self.apliClient(),
            memoryCache: self.memoryCache()
        )}
    }
    
    var datasetDataRepository: Factory<DatasetDataRepository> {
        self { @MainActor in DefaultDatasetDataRepository(
            apiClient: self.apliClient(),
            memoryCache: self.memoryCache()
        )}
    }
    
    var datasetPageRepository: Factory<DatasetPageRepository> {
        self { @MainActor in DefaultDatasetPageRepository(
            modelContext: self.persitenceDataStore().container.mainContext
        )}
    }
}
