import FactoryKit

extension Container {
    var loadDataUseCase: Factory<LoadDataUseCase> {
        self { @MainActor in LoadDataUseCase() }
    }
}

