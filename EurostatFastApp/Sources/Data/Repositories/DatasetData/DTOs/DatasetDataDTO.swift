import Domain
import Foundation

public struct DatasetDataDTO: Codable, Sendable {
    let parameters: [String: String]
    let data: [Data]
    
    var model: DatasetData {
        .init(parameters: parameters, data: data.map(\.model))
    }
}

public extension DatasetDataDTO {
    struct Data: Codable, Sendable {
        let geo: String
        let values: [String: Double]
        
        var model: DatasetData.Data {
            .init(geo: geo, values: values)
        }
    }
}
