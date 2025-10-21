import FactoryKit

extension Container {
    var pageBuilderUseCase: Factory<PageBuilderUseCase> {
        self { @MainActor in PageBuilderUseCase()}
    }
    
    var saveNewDatasetPageUseCase: Factory<SaveNewDatasetPageUseCase> {
        self { @MainActor in SaveNewDatasetPageUseCase()}
    }
    
    var loadDataMainDatasetViewUseCase: Factory<LoadDataMainDatasetViewUseCase> {
        self { @MainActor in LoadDataMainDatasetViewUseCase() }
    }
    
    var deleteDatasetPageUseCase: Factory<DeleteDatasetPageUseCase> {
        self { @MainActor in DeleteDatasetPageUseCase() }
    }
}

