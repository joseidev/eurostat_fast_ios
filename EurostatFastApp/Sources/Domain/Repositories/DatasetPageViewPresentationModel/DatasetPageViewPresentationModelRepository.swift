public protocol DatasetPageViewPresentationModelRepository: Sendable {
    func store(_ model: DatasetPageViewPresentationModel) throws
    func getModels() throws -> [DatasetPageViewPresentationModel]
    func delete(_ id: String) throws
    func deleteAll() throws
}
