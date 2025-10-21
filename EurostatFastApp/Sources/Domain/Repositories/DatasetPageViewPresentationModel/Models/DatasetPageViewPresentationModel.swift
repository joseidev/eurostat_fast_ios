import SwiftData

@Model
public final class DatasetPageViewPresentationModel {
    public var datasetPageID: String
    public var pageIndex: Int
    public var name: String
    public var items: [DatasetPageItem]
    
    public init(datasetPageID: String, pageIndex: Int, name: String, items: [DatasetPageItem]) {
        self.datasetPageID = datasetPageID
        self.pageIndex = pageIndex
        self.name = name
        self.items = items
    }
}

@Model
public final class DatasetPageItem {
    public var id: String
    public var name: String
    public var datasetChartModels: [DatasetChartModel]
    
    public init(id: String, name: String, datasetChartModels: [DatasetChartModel]) {
        self.id = id
        self.name = name
        self.datasetChartModels = datasetChartModels
    }
}

@Model
public final class DatasetChartModel {
    public var id: String
    public var period: String
    public var value: Double
    
    public init(id: String, period: String, value: Double) {
        self.id = id
        self.period = period
        self.value = value
    }
}
