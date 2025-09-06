public protocol ParameterRepository {
    func requestParameters() async throws -> [Parameter]
}
