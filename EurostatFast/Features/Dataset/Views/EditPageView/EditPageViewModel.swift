import Domain
import FactoryKit
import SwiftUI

@Observable
final class EditPageViewModel {
    let isNewPage: Bool
    var metadata: [Metadata] = []
    var geoParameter: Parameter?
    let onClose: () -> Void
    let onSave: (DatasetPageView.PresentationModel) -> Void
    var presentationModel: EditPageView.PresentationModel = .initial
    @ObservationIgnored
    @Injected(\.saveNewDatasetPageUseCase) var saveNewDatasetPageUseCase
    @ObservationIgnored
    @Injected(\.parameterRepository) var parameterRepository
    @ObservationIgnored
    @Injected(\.metadataRepository) var metadataRepository
    
    init(
        isNewPage: Bool,
        onClose: @escaping () -> Void,
        onSave: @escaping (DatasetPageView.PresentationModel) -> Void
    ) {
        self.isNewPage = isNewPage
        self.onClose = onClose
        self.onSave = onSave
    }
}

// View methods

extension EditPageViewModel {
    func onAppear() async {
        await loadData()
    }
    
    func onTapClose() {
        onClose()
    }
    
    func onTapSave() async {
        guard let geoModel = presentationModel.geoModel else {
            return
        }
        do {
            let model = try await saveNewDatasetPageUseCase.saveNewPage(geoModel)
            onSave(model)
        } catch {
            //TODO: Handle error
        }
    }
    
    func onSelectListItem(_ id: String) {
        presentationModel.updateDatasetListItem(id)
    }
    
    // TODO: Añadir método para detectar selección de selector primario y
    // limpiar seleccion de datasets ya que puede cambiar los que estén disponibles
    
    func onSelectPageType(_ pageType: PageType) {
        switch pageType {
        case .geo:
            guard
                let geoParameter,
                let presentationModel = buildGeoPresentationModel(metadata, geoParameter) else {
                return
            }
            self.presentationModel = presentationModel
        case .dataset:
            guard
                let selectedDataset = metadata.first,
                let presentationModel = buildDatasetPresentationModel(metadata, selectedDataset) else {
                return
            }
            self.presentationModel = presentationModel

        }
        
    }
}

private extension EditPageViewModel {
    typealias SelectorModels = (primarySelectorItems: [EditPageSelectorView.Item], datasetListItems: [DatasetListView.Item])
    enum Constants {
        static let geoLabel = String(localized: "Geo items")
        static let datasetLabel = String(localized: "Dataset items")
    }
    func loadData() async {
        do {
            let metadata = try await metadataRepository.requestMetadata()
            guard
                let geoParameter = try await parameterRepository.getGeoParameter(),
                let model = buildGeoPresentationModel(metadata, geoParameter)
            else {
                return
            }
            self.geoParameter = geoParameter
            self.metadata = metadata
            presentationModel = model
        } catch {
            //TODO: Handle error
        }
    }
    
    func buildGeoModels(_ metadata: [Metadata], _ geoParameter: Parameter) -> SelectorModels {
        let primarySelectorItems: [EditPageSelectorView.Item] = geoParameter.values.map {
            .init(id: $0.code, name: $0.valueDescription)
        }
        // TODO: Hay que pasar también geo item seleccionado por si no todos los datasets están disponibles para
        // todos los geos.
        // Seleccionar solo los datasets disponibles
        let datasetListItems: [DatasetListView.Item] = metadata.map {
            .init(id: $0.code, name: $0.name, isSelected: false)
        }
        return (primarySelectorItems, datasetListItems)
    }
    
    func buildGeoPresentationModel(_ metadata: [Metadata], _ geoParameter: Parameter) -> EditPageView.PresentationModel? {
        let (primarySelectorItems, datasetListItems) = buildGeoModels(metadata, geoParameter)
        guard let selectedGeoItem = primarySelectorItems.first else {
            return nil
        }
        return .init(
            primaryItemName: Constants.geoLabel,
            selectedPageType: .geo,
            selectedPrimaryItem: selectedGeoItem,
            primarySelectorItems: primarySelectorItems,
            datasetListItems: datasetListItems
        )
    }
    
    func buildDatasetModels(_ metadata: [Metadata], _ selectedDataset: Metadata) -> SelectorModels {
        let primarySelectorItems: [EditPageSelectorView.Item] = metadata.map {
            .init(id: $0.code, name: $0.name)
        }
        let datasetListItems: [DatasetListView.Item] = selectedDataset.queryParams.geo.map {
            .init(id: $0, name: $0, isSelected: false)
        }
        return (primarySelectorItems, datasetListItems)
    }
    
    func buildDatasetPresentationModel(_ metadata: [Metadata], _ selectedDataset: Metadata) -> EditPageView.PresentationModel? {
        let (primarySelectorItems, datasetListItems) = buildDatasetModels(metadata, selectedDataset)
        guard let selectedDatasetItem = primarySelectorItems.first else {
            return nil
        }
        return .init(
            primaryItemName: Constants.datasetLabel,
            selectedPageType: .dataset,
            selectedPrimaryItem: selectedDatasetItem,
            primarySelectorItems: primarySelectorItems,
            datasetListItems: datasetListItems
        )
    }
}

extension EditPageViewModel {
    enum SavedModel {
        struct Geo{
            let geoCode: String
            let datasetCodes: [String]
            
            init(geoCode: String, datasetCodes: [String]) {
                self.geoCode = geoCode
                self.datasetCodes = datasetCodes
            }
        }
        case geo(Geo)
    }
}
