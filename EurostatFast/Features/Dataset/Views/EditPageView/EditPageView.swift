import SwiftUI

struct EditPageView: View {
    let isNewPage: Bool
    let closeAction: () -> Void
    let saveAction: () -> Void
    let selectAction: (String) -> Void
    @State var selectedPageType: PageType = .geo
    
    var body: some View {
        VStack {
            HeaderView(
                isNewPage: isNewPage,
                closeAction: closeAction,
                saveAction: saveAction
            )
            .padding(.bottom, 16)
            if isNewPage {
                PageTypeSelectorView(selectedPageType: $selectedPageType)
            }
            GeoSelectorView(selectedPageType: $selectedPageType)
            DatasetListView(items: itemsMock, selectAction: selectAction)
            Spacer()
        }
        .padding()
    }
}



private struct HeaderView: View {
    let isNewPage: Bool
    let closeAction: () -> Void
    let saveAction: () -> Void
    
    var body: some View {
        HStack {
            Button("Close") {
                closeAction()
            }
            .buttonStyle(.bordered)
            Spacer()
            Text(title)
            Spacer()
            Button(isNewPage ? "Add" : "Save") {
                saveAction()
            }
            .buttonStyle(.bordered)
            
        }
    }
}

private extension HeaderView {
    var title: String {
        isNewPage ? String(localized: "Add new page") : String(localized: "Edit page")
    }
}

enum PageType: String, CaseIterable, Identifiable {
    case geo, dataset
    
    var title: String {
        .init(self == .geo ? "Geo" : "Dataset")
    }
    
    var id: String {
        self.rawValue
    }
}


private struct GeoSelectorView: View {
    @Binding var selectedPageType: PageType
    var body: some View {
        HStack {
            Text("Select Geo")
            Spacer()
            Picker("", selection: $selectedPageType) {
                ForEach(PageType.allCases) { type in
                    Text(type.title).tag(type)
                }
            }
            .pickerStyle(.menu)
        }
    }
}

private struct PageTypeSelectorView: View {
    @Binding var selectedPageType: PageType
    var body: some View {
        Picker("", selection: $selectedPageType) {
            ForEach(PageType.allCases) { type in
                Text(type.title).tag(type)
            }
        }
        .pickerStyle(.segmented)
        .frame(maxWidth: 200)
    }
}

struct ListItem: Identifiable {
    let id: UUID
    let value: String
}

private struct DatasetListView: View {
    let items: [ListItem]
    let selectAction: (String) -> Void
    
    var body: some View {
        List(items) { item in
            HStack {
                Text(item.value)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
            .onTapGesture {
                selectAction(item.value)
            }
        }
        .listStyle(.plain)
    }
}

let itemsMock: [ListItem] =
    [
        .init(id: UUID(), value: "Item 1"),
        .init(id: UUID(), value: "Item 2"),
        .init(id: UUID(), value: "Item 3"),
        .init(id: UUID(), value: "Item 4"),
        .init(id: UUID(), value: "Item 5"),
    ]

