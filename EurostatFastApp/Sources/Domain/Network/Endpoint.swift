import Foundation

public struct Endpoint {
    public let path: String
    public let method: HTTPMethod
    public let headers: [String: String]?
    public let body: Data?
    public let queryItems: [URLQueryItem]?
    
    public init(
        path: String,
        method: HTTPMethod = .get,
        headers: [String: String]? = nil,
        body: Encodable? = nil,
        query: [String: CustomStringConvertible]? = nil
    ) {
        self.path = path
        self.method = method
        self.headers = headers
        self.body = Self.buildBody(body)
        self.queryItems = Self.buildQueryParams(query)
    }
}

private extension Endpoint {
    static func buildBody(_ body: Encodable?) -> Data? {
        guard let body else {
            return nil
        }
        do {
            return try JSONEncoder().encode(body)
        } catch {
            debugPrint("⚠️ Error codificando body: \(error)")
            return nil
        }
    }
    
    static func buildQueryParams(_ query: [String: CustomStringConvertible]?) -> [URLQueryItem]? {
        guard let query else {
            return nil
        }
        return query.map { URLQueryItem(name: $0.key, value: $0.value.description) }
    }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
