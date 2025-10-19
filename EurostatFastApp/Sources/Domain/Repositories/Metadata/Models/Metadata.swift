import Foundation
import SwiftData

@Model
public final class Metadata: Hashable, Identifiable {
    public var id: Int
    public var code: String
    public var eurostatLastUpdate: Date
    public var name: String
    public var dataStart: String
    public var dataEnd: String
    public var fixedParams: [String: String]
    public var queryParams: MetadataQueryParams
    
    public init(
        id: Int,
        code: String,
        eurostatLastUpdate: Date,
        name: String,
        dataStart: String,
        dataEnd: String,
        fixedParams: [String : String],
        queryParams: MetadataQueryParams
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

@Model
public final class MetadataQueryParams: Hashable {
    public var geo: [String]
    
    public init(geo: [String]) {
        self.geo = geo
    }
}

