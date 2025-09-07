import Domain
import Foundation

extension Data {
    func decode<T: Decodable>() throws -> T {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(T.self, from: self)
        } catch {
            throw APIError.decodingError(error)
        }
    }
}
