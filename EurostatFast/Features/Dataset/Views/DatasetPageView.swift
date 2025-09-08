import SwiftUI

struct DatasetPageView: View {
    struct PresentationModel: Hashable {
        let name: String
        let items: [DatasetItemView.PresentationModel]
    }
    let presentationModel: PresentationModel
    
    var body: some View {
        VStack {
            Text(presentationModel.name)
                .font(.title)
            ScrollView {
                ForEach(presentationModel.items) { item in
                    DatasetItemView(presentationModel: item)                        
                }
            }
            .scrollIndicators(.hidden)
            .padding(.bottom, 24)
            Spacer()
        }
        .padding()
    }
}
