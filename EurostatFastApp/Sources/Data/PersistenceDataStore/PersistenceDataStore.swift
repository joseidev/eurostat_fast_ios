import Domain
import SwiftData

public struct DefaultPersistenceDataStore: PersistenceDataStore {
    public let container: ModelContainer
    
    init(container: ModelContainer) {
        self.container = container
    }
    
    public static func makeDefault() throws -> PersistenceDataStore {
        let container = try ModelContainer(
            for: DatasetPage.self,
            Metadata.self,
            Parameter.self
        )
        return DefaultPersistenceDataStore(container: container)
    }
}

