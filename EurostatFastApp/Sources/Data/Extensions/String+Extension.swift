import Foundation

extension [String] {
    var geoQueryDict: [String: CustomStringConvertible] {
        var result: [String: CustomStringConvertible] = [:]
        self.forEach { result["geo"] = $0 }
        return result
    }
}
