extension MainDatasetViewModel {
    enum State {
        case loading
        case empty
        case loaded([DatasetPageView.PresentationModel])
    }
}
