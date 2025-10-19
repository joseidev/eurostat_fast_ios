import FactoryKit

extension Container {
    var loadDataUseCase: Factory<LoadDataUseCase> {
        self { @MainActor in LoadDataUseCase() }
    }

    var pageBuilderUseCase: Factory<PageBuilderUseCase> {
        self { @MainActor in PageBuilderUseCase()}
    }
}

