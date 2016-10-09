enum State {
    case loading, empty, result
}

extension ProductListViewController {
    func setState(state: State) {
        let shoudHideContainer = state == .result
        emptyStateContainer?.isHidden = shoudHideContainer

        let shouldHideSpinner = state != .loading
        activityIndicator?.isHidden = shouldHideSpinner

        let shoudHideLabel = state != .empty
        emptyStateLabel?.isHidden = shoudHideLabel
    }
}
