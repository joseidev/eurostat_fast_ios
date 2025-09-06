import Domain
import FactoryKit
import SwiftUI

struct ContentView: View {
    @Injected(\.metadataRepository) private var metadataRepository
    
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
                let metadata = try await metadataRepository.requestMetadata()
                print(metadata)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    ContentView()
}
