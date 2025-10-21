import Foundation
import SwiftData

@Model
public class DatasetPage {
    public var id: String = UUID().uuidString
    public var pageIndex: Int
    public var geoCode: String
    public var datasetCodes: [String]
    
    public init(
        pageIndex: Int,
        geoCode: String,
        datasetCodes: [String]
    ) {
        self.pageIndex = pageIndex
        self.geoCode = geoCode
        self.datasetCodes = datasetCodes
    }
    
    public func update(
        pageIndex: Int,
        geoCode: String,
        datasetCodes: [String]
    ) {
        self.pageIndex = pageIndex
        self.geoCode = geoCode
        self.datasetCodes = datasetCodes
    }
}

