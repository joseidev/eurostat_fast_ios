public protocol ParameterRepository: Sendable {
    func requestParameters() async throws -> [Parameter]
    func getGeoParameter() async throws -> Parameter?
    func deleteAll() throws
}
