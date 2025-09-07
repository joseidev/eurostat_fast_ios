import Domain
import Foundation

public struct DefaultAPIClient: APIClient {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let request = try endpoint.buildRequest()
        DataHelpers.log(request: request)
        let (data, response) = try await session.data(for: request)
        DataHelpers.log(response: data, response)
        return try handleResponse(data, response)
    }
}

private extension APIClient {
    func handleResponse<T: Decodable>(_ data: Data, _ response: URLResponse) throws -> T {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.statusCode(httpResponse.statusCode)
        }
        return try data.decode()
    }
}
