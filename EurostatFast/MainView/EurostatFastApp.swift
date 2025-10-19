import Domain
import SwiftData
import SwiftUI

let container = try! ModelContainer(
    for: DatasetPage.self
)

@main
struct EurostatFastApp: App {
    var body: some Scene {
        WindowGroup {
            MainDatasetView()
                .ignoresSafeArea(edges: .bottom)
        }
    }
}
