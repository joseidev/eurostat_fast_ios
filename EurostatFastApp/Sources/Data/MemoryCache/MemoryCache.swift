import Domain
import Foundation

public final class DefaultMemoryCache: MemoryCache {
    private var cache = [String: Codable]()
    
    public init() {}
    
    
    public func set<T: Codable>(_ key: String, _ object: T) {
        cache[key] = object
    }
    
    public func get<T: Codable>(_ key: String) -> T? {
        guard let data = cache[key] as? T else { return nil }
        return data
    }
    
    public func clear() {
        cache.removeAll()
    }
}

