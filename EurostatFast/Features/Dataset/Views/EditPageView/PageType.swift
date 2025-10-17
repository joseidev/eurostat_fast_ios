import Foundation

enum PageType: String, CaseIterable, Identifiable {
    case geo, dataset
    
    var title: String {
        .init(self == .geo ? "Geo" : "Dataset")
    }
    
    var id: String {
        self.rawValue
    }
}
