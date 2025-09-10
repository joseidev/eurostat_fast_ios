import Domain
import Foundation

public actor DefaultMemoryCache: MemoryCache {
    private var cache = [String: Codable]()
    
    public init() {}
    
    
    public func set<T: Codable>(_ key: String, _ object: T) {
        cache[key] = object
    }
    
    public func get<T: Codable>(_ key: String) throws -> T {
        guard let data = cache[key] as? T else {
            throw APIError.notFoundInCache
        }
        return data
    }
    
    public func clear() {
        cache.removeAll()
    }
}

