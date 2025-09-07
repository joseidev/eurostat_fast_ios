import Data
import Domain
import FactoryKit
import Foundation

extension Container {
    var apliClient: Factory<APIClient> {
        self { DefaultAPIClient() }
    }
    
    var memoryCache: Factory<MemoryCache> {
        self { MemoryCache() }.singleton
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
}
