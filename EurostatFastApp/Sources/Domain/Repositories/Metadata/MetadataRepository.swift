public protocol MetadataRepository {
    func requestMetadata() async throws -> [Metadata]
}
