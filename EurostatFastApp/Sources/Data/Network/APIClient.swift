import Foundation

protocol APIClient {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

final class DefaultAPIClient: APIClient {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let request = try buildRequest(endpoint)
        log(request: request)
        let (data, response) = try await session.data(for: request)
        log(response: data, response)
        return try handleResponse(data, response)
    }
}

private extension APIClient {
    func buildRequest(_ endpoint: Endpoint) throws -> URLRequest {
        guard var components = URLComponents(string: APIConfig.baseURL + endpoint.path) else {
            throw APIError.invalidURL
        }
        if let queryItems = endpoint.queryItems {
            components.queryItems = queryItems
        }
        guard let url = components.url else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        var allHeaders = APIConfig.commonHeaders
        if let endpointHeaders = endpoint.headers {
            allHeaders.merge(endpointHeaders) { _, new in new }
        }
        request.allHTTPHeaderFields = allHeaders
        request.httpBody = endpoint.body
        return request
    }
    
    func handleResponse<T: Decodable>(_ data: Data, _ response: URLResponse) throws -> T {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.statusCode(httpResponse.statusCode)
        }
        return try decode(data)
    }
    
    func decode<T: Decodable>(_ data: Data) throws -> T {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIError.decodingError(error)
        }
    }
    
    
    func log(request: URLRequest) {
        print("➡️ Request:")
        
        // Método y URL
        let method = request.httpMethod ?? "UNKNOWN"
        let url = request.url?.absoluteString ?? "NO_URL"
        print("\(method) \(url)")
        
        // Headers
        if let headers = request.allHTTPHeaderFields, !headers.isEmpty {
            print("Headers:")
            for (key, value) in headers {
                print("  \(key): \(value)")
            }
        }
        
        // Body
        if let body = request.httpBody, !body.isEmpty {
            if let jsonObject = try? JSONSerialization.jsonObject(with: body),
               let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted]),
               let prettyString = String(data: prettyData, encoding: .utf8) {
                print("Body (JSON):\n\(prettyString)")
            } else if let bodyString = String(data: body, encoding: .utf8) {
                print("Body (String):\n\(bodyString)")
            } else {
                print("Body: \(body.count) bytes (non-printable)")
            }
        }
        
        print("----- End Request -----\n")
    }

    func log(response data: Data, _ response: URLResponse) {
        print("⬅️ Response:")
        
        // Status code y URL
        if let httpResponse = response as? HTTPURLResponse {
            let url = httpResponse.url?.absoluteString ?? "NO_URL"
            print("\(httpResponse.statusCode) \(url)")
            
            // Headers
            if !httpResponse.allHeaderFields.isEmpty {
                print("Headers:")
                for (key, value) in httpResponse.allHeaderFields {
                    print("  \(key): \(value)")
                }
            }
        } else {
            print("Response is not HTTPURLResponse")
        }
        
        // Body
        if !data.isEmpty {
            if let jsonObject = try? JSONSerialization.jsonObject(with: data),
               let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted]),
               let prettyString = String(data: prettyData, encoding: .utf8) {
                print("Body (JSON):\n\(prettyString)")
            } else if let bodyString = String(data: data, encoding: .utf8) {
                print("Body (String):\n\(bodyString)")
            } else {
                print("Body: \(data.count) bytes (non-printable)")
            }
        }
        
        print("----- End Response -----\n")
    }

}
