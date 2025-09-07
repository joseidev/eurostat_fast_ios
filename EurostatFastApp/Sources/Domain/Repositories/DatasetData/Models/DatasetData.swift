import Foundation

public struct DatasetData {
    public let parameters: [String: String]
    public let data: [Data]
    
    public init(parameters: [String : String], data: [Data]) {
        self.parameters = parameters
        self.data = data
    }
}

public extension DatasetData {
    struct Data {
        public let geo: String
        public let values: [String: Double]
        
        public init(geo: String, values: [String : Double]) {
            self.geo = geo
            self.values = values
        }
    }
}
