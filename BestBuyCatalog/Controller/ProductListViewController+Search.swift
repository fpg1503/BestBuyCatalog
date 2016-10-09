import UIKit

extension ProductListViewController: UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {

    @IBAction func showSearchBar() {
        guard !isSearching else { return }
        isSearching = true

        navigationItem.hidesBackButton = true

        let searchController = UISearchController(searchResultsController:  nil)

        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.delegate = self

        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false

        navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true

        searchController.searchBar.becomeFirstResponder()

        self.searchController = searchController
    }

    public func updateSearchResults(for searchController: UISearchController) {
        searchText = searchController.searchBar.text
    }

    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchText = ""
    }
}
