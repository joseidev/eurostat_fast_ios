import Foundation

public struct Parameter: Hashable, Identifiable {
    public let code: String
    public let name: String
    public let description: String
    public let values: [Value]
    
    public var id: String {
        code
    }
    
    public init(code: String, name: String, description: String, values: [Value]) {
        self.code = code
        self.name = name
        self.description = description
        self.values = values
    }
}

public extension Parameter {
    struct Value: Hashable {
        public let code: String
        public let description: String
        
        public init(code: String, description: String) {
            self.code = code
            self.description = description
        }
    }
}
