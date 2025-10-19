import Domain
import FactoryKit
import SwiftData
import SwiftUI


@Observable
final class MainDatasetViewModel {
    @ObservationIgnored
    @Injected(\.loadDataUseCase) var loadDataUseCase
    @ObservationIgnored
    @Injected(\.datasetDataRepository) var datasetDataRepository
    @ObservationIgnored
    @Injected(\.pageBuilderUseCase) var pageBuilderUseCase
    @ObservationIgnored
    var metadata: [Metadata] = []
    @ObservationIgnored
    lazy var geoParameter: Parameter? = parameters.geoParameter
    var state: State = .loading
    private var parameters: [Parameter] = []
    private let context = container.mainContext
}

// MARK: - View actions
extension MainDatasetViewModel {
    func onAppear() async {
        do {
            let (metadata, parameters) = try await loadDataUseCase.load()
            self.metadata = metadata
            self.parameters = parameters
            state = .loaded([])
        } catch {
            state = .empty
        }
    }

    func onTapDeletePage(_ selectedPageIndex: Int) {
        print("didTapDeletePage", selectedPageIndex)
        printObjects()
        
    }

    func onSavePage(_ savedModel: EditPageViewModel.SavedModel) async {
        switch savedModel {
            case let  .geo(geoModel):
                await saveGeoModel(geoModel)
        }
    }
}

private extension MainDatasetViewModel {
    func saveGeoModel(_ geoModel: EditPageViewModel.SavedModel.Geo) async {
        do {
            let pageIndex = try getLastPageIndex() + 1
            context.insert(geoModel.buildDatasetPage(pageIndex))
            try context.save()
            guard let geoParameter else { return }
            let model = try await pageBuilderUseCase.buildGeoModel(
                pageIndex,
                geoModel,
                metadata,
                geoParameter
            )
            state = .loaded([model])
        } catch {
            //TODO: Handle error
        }
    }
    
    func getLastPageIndex() throws -> Int {
        let datasetPages = FetchDescriptor<DatasetPage>(
            sortBy: [
                .init(\.pageIndex)
            ]
        )
        return try context.fetch(datasetPages).last?.pageIndex ?? 0
    }
    
    func printObjects() {
        let datasetPages = FetchDescriptor<DatasetPage>(
            sortBy: [
                .init(\.pageIndex)
            ]
        )
        let results = try? context.fetch(datasetPages)
        results?.forEach {
            print($0.pageIndex)
            print($0.geoCode)
            print($0.datasetCodes)
        }
    }
}

extension EditPageViewModel.SavedModel.Geo {
    func buildDatasetPage(_ index: Int) -> DatasetPage {
        .Root(pageIndex: index, geoCode: self.geoCode, datasetCodes: self.datasetCodes)
    }
}
