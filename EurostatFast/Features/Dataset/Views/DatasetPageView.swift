import SwiftUI

struct DatasetPageView: View {
    var body: some View {
        VStack {
            Text("España")
                .font(.title)
            ScrollView {
                DatasetItemView()
                    .padding(.top, 8)
                DatasetItemView()
                    .padding(.top, 8)
                DatasetItemView()
                    .padding(.top, 8)
                DatasetItemView()
                    .padding(.top, 8)
            }
            .scrollIndicators(.hidden)
            Spacer()
        }
    }
}
