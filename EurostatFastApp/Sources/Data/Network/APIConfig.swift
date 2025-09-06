import Foundation

struct APIConfig {
    static let baseURL = "http://127.0.0.1:8000/v1/"
    static let apiKey = "o0qW3Wm5kJH79q7iprqdiIs0thln5WnPwgMivQ5Fbiw" // ⚠️ Mejor guardarlo en Keychain o Secrets
    
    static var commonHeaders: [String: String] {
        [
            "x-api-key": apiKey,
            "Content-Type": "application/json"
        ]
    }
}
