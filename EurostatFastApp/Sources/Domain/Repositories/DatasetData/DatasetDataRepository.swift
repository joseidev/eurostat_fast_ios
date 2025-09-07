public protocol DatasetDataRepository {
    func requestDatasetData(_ code: String, _ geoValues: [String]) async throws -> DatasetData
}
