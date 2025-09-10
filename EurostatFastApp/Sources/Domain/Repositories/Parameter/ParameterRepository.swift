public protocol ParameterRepository: Sendable {
    func requestParameters() async throws -> [Parameter]
}
