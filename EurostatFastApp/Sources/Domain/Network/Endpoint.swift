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
        if let body {
            do {
                self.body = try JSONEncoder().encode(body)
            } catch {
                self.body = nil
                debugPrint("⚠️ Error codificando body: \(error)")
            }
        } else {
            self.body = nil
        }
        if let query = query {
            self.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value.description) }
        } else {
            self.queryItems = nil
        }
    }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
