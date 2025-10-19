
public protocol DatasetPageRepository: Sendable {
    func store(_ datasetPage: DatasetPage) throws
    func getLastPageIndex() throws -> Int?
    func update(
        id: String,
        pageIndex: Int,
        geoCode: String,
        datasetCodes: [String]
    ) throws
    func delete(_ datasetPage: DatasetPage)
    func deleteAll() throws
}
