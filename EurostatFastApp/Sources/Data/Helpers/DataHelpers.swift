import Foundation

enum DataHelpers {
    static func buildMemoryCacheKey(_ path: String, _ code: String, _ geoValues: [String]) -> String {
        path + "/\(code)" + geoValues.joined(separator: ",")
    }
}
