public protocol MetadataRepository: Sendable {
    func requestMetadata() async throws -> [Metadata]
}
