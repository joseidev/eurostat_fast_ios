public protocol DatasetDataRepository: Sendable {
    func requestDatasetData(_ code: String, _ geoValues: [String]) async throws -> DatasetData
}
