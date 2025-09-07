import Foundation

public protocol MemoryCache {
    func set<T: Codable>(_ key: String, _ object: T)
    func get<T: Codable>(_ key: String) -> T?
    func clear()
}

