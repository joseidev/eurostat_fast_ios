import SwiftUI

struct EditPageView: View {
    @State var viewModel: EditPageViewModel

    var body: some View {
        VStack(spacing: 16) {
            HeaderView(
                isNewPage: viewModel.isNewPage,
                closeAction: viewModel.onTapClose,
                saveAction: viewModel.onTapSave
            )
            .padding(.bottom, 16)
            if viewModel.isNewPage {
                PageTypeSelectorView(selectedPageType: $viewModel.presentationModel.selectedPageType)
            }
            EditPageSelectorView(
                name: viewModel.presentationModel.primaryItemName,
                items: viewModel.presentationModel.primarySelectorItems,
                selectedItem: $viewModel.presentationModel.selectedPrimaryItem
            )
            Divider()
            DatasetListView(
                items: viewModel.presentationModel.datasetListItems,
                selectAction: viewModel.onSelectListItem
            )
            .padding(.top, 16)
            Spacer()
        }
        .padding()
        .onChange(of: viewModel.presentationModel.selectedPageType) { _ , new in
            viewModel.onSelectPageType(new)
        }
        .task {
            await viewModel.onAppear()
        }
    }
}

private struct HeaderView: View {
    let isNewPage: Bool
    let closeAction: () -> Void
    let saveAction: () async -> Void
    
    var body: some View {
        HStack {
            Button("Close") {
                closeAction()
            }
            .buttonStyle(.bordered)
            Spacer()
            Text(title)
            Spacer()
            Button(isNewPage ? String(localized: "Add") : String(localized: "Save")) {
                Task {
                    await saveAction()
                }
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



struct EditPageSelectorView: View {
    struct Item: Identifiable, Hashable {
        let id: String
        let name: String
    }
    let name: String
    let items: [Item]
    @Binding var selectedItem: Item
    var body: some View {
        HStack {
            Text(name)
            Spacer()
            Picker("", selection: $selectedItem) {
                ForEach(items, id: \.self) { item in
                    Text(item.name).tag(item)
                }
            }
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
    struct Item: Identifiable, Hashable {
        let id: String
        let name: String
        var isSelected: Bool
    }
    let items: [Item]
    let selectAction: (String) -> Void
    
    var body: some View {
        VStack {
            HStack {
                Text("Datasets")
                    .fontWeight(.bold)
                Spacer()
            }
            List(items) { item in
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
