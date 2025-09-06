import Foundation

public protocol APIClient {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}
