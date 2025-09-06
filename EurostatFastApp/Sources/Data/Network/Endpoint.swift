// Data/Network/Endpoints.swift
import Foundation

struct Endpoint {
    let path: String
    let method: HTTPMethod
    let headers: [String: String]?
    let body: Data?
    let queryItems: [URLQueryItem]?
    
    init(
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

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
