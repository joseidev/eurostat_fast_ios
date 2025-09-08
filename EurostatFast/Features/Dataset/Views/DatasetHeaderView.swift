import SwiftUI

struct DatasetHeaderView: View {
    let editAction: () -> Void
    let addAction: () -> Void
    let deleteAction: () -> Void
    
    var body: some View {
        HStack {
            Text("Eurostat Fast")
            Spacer()
            Menu {
                Button("Edit page") { editAction() }
                Button("Add new page") { addAction() }
                Divider()
                Button("Delete page", role: .destructive) { deleteAction() }
            } label: {
                Image(systemName: "ellipsis.circle")
            }
        }
    }
}
