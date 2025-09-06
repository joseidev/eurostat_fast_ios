import Foundation

public struct Metadata {
    public let id: Int
    public let code: String
    public let eurostatLastUpdate: Date
    public let name: String
    public let dataStart: String
    public let dataEnd: String
    public let fixedParams: [String: String]
    let queryParams: QueryParams
    
    public init(
        id: Int,
        code: String,
        eurostatLastUpdate: Date,
        name: String,
        dataStart: String,
        dataEnd: String,
        fixedParams: [String : String],
        queryParams: QueryParams
    ) {
        self.id = id
        self.code = code
        self.eurostatLastUpdate = eurostatLastUpdate
        self.name = name
        self.dataStart = dataStart
        self.dataEnd = dataEnd
        self.fixedParams = fixedParams
        self.queryParams = queryParams
    }
}

public extension Metadata {
    struct QueryParams {
        public let geo: [String]
        
        public init(geo: [String]) {
            self.geo = geo
        }
    }
}
