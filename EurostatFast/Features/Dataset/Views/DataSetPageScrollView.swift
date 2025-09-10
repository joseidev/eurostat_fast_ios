import SwiftUI

struct DataSetPageScrollView<Content: View>: View {
    @Binding var selectedPageIndex: Int
    let content: Content
    
    init(        
        selectedPageIndex: Binding<Int>,
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self._selectedPageIndex = selectedPageIndex
    }
    var body: some View {
        TabView(selection: $selectedPageIndex) {
            content
        }
        .tabViewStyle(.page)        
    }
}
