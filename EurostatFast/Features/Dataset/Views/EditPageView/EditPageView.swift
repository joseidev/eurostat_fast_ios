import SwiftUI

struct EditPageView: View {
    let isNewPage: Bool
    let closeAction: () -> Void
    let saveAction: () -> Void
    let selectAction: (String) -> Void
    @State private var selectedItem: SelectorView.PresentationModel.Item?
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
            SelectorView(selectedPageType: $selectedItem)
            Divider()
            DatasetListView(presentationModel: .init(name: "Datesets", items: itemsMock), selectAction: selectAction)
                .padding(.top, 16)
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

private struct SelectorView: View {
    struct PresentationModel: Hashable {
        struct Item: Identifiable, Hashable {
            let id: String
            let name: String
        }
        let name: String
        let items: [Item]
    }
    let presentationModel: PresentationModel
    @Binding var selectedItem: PresentationModel.Item
    var body: some View {
        HStack {
            Text(presentationModel.name)
            Spacer()
            Picker("", selection: $selectedItem) {
                ForEach(presentationModel.items) { item in
                    Text(item.name).tag(item.id)
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

struct DatasetListView: View {
    struct PresentationModel {
        struct Item: Identifiable, Hashable {
            let id: String
            let name: String
            let isSelected: Bool
        }
        let name: String
        let items: [Item]
    }
    let presentationModel: PresentationModel
    let selectAction: (String) -> Void
    
    var body: some View {
        VStack {
            HStack {
                Text(presentationModel.name)
                    .fontWeight(.bold)
                Spacer()
            }
            List(presentationModel.items) { item in
                HStack {
                    Text(item.name)
                    Spacer()
                    if item.isSelected {
                        Image(systemName: "checkmark")
                    }
                }
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
                .onTapGesture {
                    selectAction(item.id)
                }
            }
            .listStyle(.plain)
        }
    }
}

let itemsMock: [DatasetListView.PresentationModel.Item] =
    [
        .init(id: UUID().uuidString, name: "Item 1", isSelected: false),
        .init(id: UUID().uuidString, name: "Item 2", isSelected: true),
        .init(id: UUID().uuidString, name: "Item 3", isSelected: false),
        .init(id: UUID().uuidString, name: "Item 4", isSelected: true),
        .init(id: UUID().uuidString, name: "Item 5", isSelected: false),
    ]

