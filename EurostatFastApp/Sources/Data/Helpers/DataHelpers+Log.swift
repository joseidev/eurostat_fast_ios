import Foundation

extension DataHelpers {
    static func log(request: URLRequest) {
        print("➡️ Request:")
        
        // Método y URL
        let method = request.httpMethod ?? "UNKNOWN"
        let url = request.url?.absoluteString ?? "NO_URL"
        print("\(method) \(url)")
        
        // Headers
        if let headers = request.allHTTPHeaderFields, !headers.isEmpty {
            print("Headers:")
            for (key, value) in headers {
                print("  \(key): \(value)")
            }
        }
        
        // Body
        if let body = request.httpBody, !body.isEmpty {
            if let jsonObject = try? JSONSerialization.jsonObject(with: body),
               let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted]),
               let prettyString = String(data: prettyData, encoding: .utf8) {
                print("Body (JSON):\n\(prettyString)")
            } else if let bodyString = String(data: body, encoding: .utf8) {
                print("Body (String):\n\(bodyString)")
            } else {
                print("Body: \(body.count) bytes (non-printable)")
            }
        }
        
        print("----- End Request -----\n")
    }

    static func log(response data: Data, _ response: URLResponse) {
        print("⬅️ Response:")
        
        // Status code y URL
        if let httpResponse = response as? HTTPURLResponse {
            let url = httpResponse.url?.absoluteString ?? "NO_URL"
            print("\(httpResponse.statusCode) \(url)")
            
            // Headers
            if !httpResponse.allHeaderFields.isEmpty {
                print("Headers:")
                for (key, value) in httpResponse.allHeaderFields {
                    print("  \(key): \(value)")
                }
            }
        } else {
            print("Response is not HTTPURLResponse")
        }
        
        // Body
        if !data.isEmpty {
            if let jsonObject = try? JSONSerialization.jsonObject(with: data),
               let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted]),
               let prettyString = String(data: prettyData, encoding: .utf8) {
                print("Body (JSON):\n\(prettyString)")
            } else if let bodyString = String(data: data, encoding: .utf8) {
                print("Body (String):\n\(bodyString)")
            } else {
                print("Body: \(data.count) bytes (non-printable)")
            }
        }
        
        print("----- End Response -----\n")
    }
}
