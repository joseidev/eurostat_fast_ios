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
        queryItems: [URLQueryItem]? = nil
    ) {
        self.path = path
        self.method = method
        self.headers = headers
        self.body = Self.buildBody(body)
        self.queryItems = queryItems
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
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
