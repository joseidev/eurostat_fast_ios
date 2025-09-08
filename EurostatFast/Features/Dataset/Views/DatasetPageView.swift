import SwiftUI

struct DatasetPageView: View {
    var body: some View {
        VStack {
            Text("España")
            DatasetItemView()
                .padding(.top, 16)
            Spacer()
        }
    }
}
