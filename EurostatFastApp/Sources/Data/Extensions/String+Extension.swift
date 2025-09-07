import Foundation

extension [String] {
    var geoQueryItems: [URLQueryItem] {
        self.map { .init(name: "geo", value: $0)}
    }
}
