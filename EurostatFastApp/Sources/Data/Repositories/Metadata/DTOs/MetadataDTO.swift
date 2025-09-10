import Domain
import Foundation

struct MetadataDTO: Codable, Sendable {
    let id: Int
    let code: String
    let eurostatLastUpdate: Date
    let name: String
    let dataStart: String
    let dataEnd: String
    let fixedParams: [String: String]
    let queryParams: MetadataDTO.QueryParams
    
    var model: Metadata {
        .init(
            id: id,
            code: code,
            eurostatLastUpdate: eurostatLastUpdate,
            name: name,
            dataStart: dataStart,
            dataEnd: dataEnd,
            fixedParams: fixedParams,
            queryParams: queryParams.model
        )
    }
}

extension MetadataDTO {
    struct QueryParams: Codable, Sendable {
        let geo: [String]?
        
        var model: Metadata.QueryParams {
            .init(geo: geo ?? [])
        }
    }
    
}
