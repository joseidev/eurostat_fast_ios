import Domain
import Foundation

extension Endpoint {
    func buildRequest() throws -> URLRequest {
        guard var components = URLComponents(string: APIConfig.baseURL + self.path) else {
            throw APIError.invalidURL
        }
        if let queryItems = self.queryItems {
            components.queryItems = queryItems
        }
        guard let url = components.url else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue
        var allHeaders = APIConfig.commonHeaders
        if let endpointHeaders = self.headers {
            allHeaders.merge(endpointHeaders) { _, new in new }
        }
        request.allHTTPHeaderFields = allHeaders
        request.httpBody = self.body
        return request
    }
}
