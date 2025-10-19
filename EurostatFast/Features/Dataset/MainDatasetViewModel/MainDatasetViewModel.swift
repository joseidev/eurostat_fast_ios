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
    @Injected(\.datasetPageRepository) var datasetPageRepository
    @ObservationIgnored
    var metadata: [Metadata] = []
    @ObservationIgnored
    lazy var geoParameter: Parameter? = parameters.geoParameter
    var state: State = .loading
    private var parameters: [Parameter] = []
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
    }

    func onSaveNewPage(_ savedModel: EditPageViewModel.SavedModel) async {
        switch savedModel {
            case let  .geo(geoModel):
                await saveGeoModel(geoModel)
        }
    }
}

private extension MainDatasetViewModel {
    func saveGeoModel(_ geoModel: EditPageViewModel.SavedModel.Geo) async {
        do {
            let lastPageIndex = try datasetPageRepository.getLastPageIndex() ?? -1
            let pageIndex = lastPageIndex + 1
            try datasetPageRepository.store(geoModel.buildNewDatasetPage(pageIndex))
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
}

extension EditPageViewModel.SavedModel.Geo {
    func buildNewDatasetPage(_ index: Int) -> DatasetPage {
        .init(
            pageIndex: index,
            geoCode: self.geoCode,
            datasetCodes: self.datasetCodes
        )
    }
}
