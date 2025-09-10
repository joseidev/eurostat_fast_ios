import Foundation

public protocol MemoryCache: Actor {
    func set<T: Codable>(_ key: String, _ object: T)
    func get<T: Codable>(_ key: String) throws -> T
    func clear()
}

