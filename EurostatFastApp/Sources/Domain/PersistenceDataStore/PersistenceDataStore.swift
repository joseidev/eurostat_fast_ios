import SwiftData

public protocol PersistenceDataStore {
    var container: ModelContainer { get }
}
