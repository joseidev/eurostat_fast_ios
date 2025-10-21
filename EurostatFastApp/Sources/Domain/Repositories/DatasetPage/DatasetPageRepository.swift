
public protocol DatasetPageRepository: Sendable {
    func store(_ datasetPage: DatasetPage) throws
    func getModels() throws -> [DatasetPage]
    func getLastPageIndex() throws -> Int?
    func update(
        id: String,
        pageIndex: Int,
        geoCode: String,
        datasetCodes: [String]
    ) throws
    func delete(_ id: String) throws
    func deleteAll() throws
}
