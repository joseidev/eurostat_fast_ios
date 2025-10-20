import FactoryKit

extension Container {
    var pageBuilderUseCase: Factory<PageBuilderUseCase> {
        self { @MainActor in PageBuilderUseCase()}
    }
    
    var saveNewDatasetPageUseCase: Factory<SaveNewDatasetPageUseCase> {
        self { @MainActor in SaveNewDatasetPageUseCase()}
    }
}

