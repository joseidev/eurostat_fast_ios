import Domain
import SwiftUI

@main
struct EurostatFastApp: App {
    var body: some Scene {
        WindowGroup {
            MainDatasetView()
                .ignoresSafeArea(edges: .bottom)
        }
    }
}
