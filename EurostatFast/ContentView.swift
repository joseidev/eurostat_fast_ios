import Domain
import Data
import FactoryKit
import SwiftUI

struct ContentView: View {
    @Injected(\.datasetDataRepository) var datasetDataRepository
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
            let values = try await datasetDataRepository.requestDatasetData("TEINA010", ["ES", "IT"])
            print(values)
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    ContentView()
}
