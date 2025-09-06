import Data
import SwiftUI

struct ContentView: View {
    let data = DataMain()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            data.test()
        }
    }
}

#Preview {
    ContentView()
}
