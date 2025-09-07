import Domain
import Data
import FactoryKit
import SwiftUI

struct ContentView: View {
    @Injected(\.parameterRepository) var parameterRepository
    @Injected(\.memoryCache) var memoryCache
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button(action: {
                Task {
                    await request()
                }
            }, label: {
                Text("Request")
            })
            Button(action: {
                memoryCache.clear()
            }, label: {
                Text("Clear")
            })
        }
        .padding()
    }
    
    func request() async {
        do {
            let parameters = try await parameterRepository.requestParameters()
            print(parameters)
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    ContentView()
}
