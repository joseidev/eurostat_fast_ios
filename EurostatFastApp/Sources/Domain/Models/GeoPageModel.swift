public struct GeoPageModel {
    public let name: String
    public let geoCode: String
    public let datasetCodes: [String]
    
    public init(name: String, geoCode: String, datasetCodes: [String]) {
        self.name = name
        self.geoCode = geoCode
        self.datasetCodes = datasetCodes
    }
}
