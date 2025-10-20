import Foundation
import SwiftData

@Model
public final class Parameter: Hashable, Identifiable {
    public var code: String
    public var name: String
    public var parameterDescription: String
    public var values: [ParameterValue]
    
    public var id: String {
        code
    }
    
    public init(code: String, name: String, parameterDescription: String, values: [ParameterValue]) {
        self.code = code
        self.name = name
        self.parameterDescription = parameterDescription
        self.values = values
    }
}

@Model
public final class ParameterValue: Hashable {
    public var code: String
    public var valueDescription: String
    
    public init(code: String, valueDescription: String) {
        self.code = code
        self.valueDescription = valueDescription
    }
}

public extension [Parameter] {
    var geoParameter: Parameter? {
        self.first(where: { $0.code == "geo" })
    }
}
