import Domain
import FactoryKit
import SwiftUI

struct ContentView: View {
    @Injected(\.parameterRepository) var parameterRepository
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .task {
            do {
                let parameters = try await parameterRepository.requestParameters()
                print(parameters)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    ContentView()
}
