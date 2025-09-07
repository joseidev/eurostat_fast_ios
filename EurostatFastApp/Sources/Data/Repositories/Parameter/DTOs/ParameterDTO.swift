import Domain
import Foundation

struct ParameterDTO: Codable {
    let code: String
    let name: String
    let description: String
    let parameterValues: [Value]
    
    var model: Parameter {
        .init(
            code: code,
            name: name,
            description: description,
            values: parameterValues.map(\.model)
        )
    }
}

extension ParameterDTO {
    struct Value: Codable {
        let code: String
        let description: String
        
        var model: Parameter.Value {
            .init(code: code, description: description)
        }
    }
}
