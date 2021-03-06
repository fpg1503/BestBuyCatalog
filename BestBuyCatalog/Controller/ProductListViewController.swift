import UIKit

public final class ProductListViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView?

    @IBOutlet var activityIndicator: UIActivityIndicatorView?
    @IBOutlet var emptyStateContainer: UIView?
    @IBOutlet var emptyStateLabel: UILabel?

    var products: [Product] = []

    private let client = APIClient()
    private let category = "abcat0401000"

    private var nextPage = 1
    private var totalPages = 1

    var oldProductsCount = 0
    var sort: Sort = .salePriceDescending {
        didSet {
            let isNewValue = sort != oldValue
            cleanAndReload(destructive: isNewValue)
        }
    }

    var searchText: String? {
        didSet {
            let isNewValue = searchText != oldValue
            cleanAndReload(destructive: isNewValue)
        }
    }

    let refreshControl = UIRefreshControl()

    var selectedProduct: Product?

    var searchController: UISearchController?

    var state: State = .loading {
        didSet {
            setState(state: state)
        }
    }

    var isSearching: Bool = false {
        didSet {
            if !isSearching {
                navigationItem.titleView = nil
            }
        }
    }

    func cleanAndReload(destructive: Bool = false) {
        nextPage = 1

        if destructive {
            oldProductsCount = 0
            totalPages = 1
            products = []
            state = .loading
            collectionView?.reloadData()
        }

        loadMoreProducts(page: 1) { (success, _) in
            self.refreshControl.endRefreshing()
            if let success = success {
                self.nextPage = 1
                self.oldProductsCount = 0
                self.products = []
                self.state = success.items.isEmpty ? .empty : .result
            }
        }
    }

    typealias ProductsCompletion = (Response<Product>?, Error?) -> Void
    func loadMoreProducts(page: Int? = nil, completion: ProductsCompletion? = nil) {
        let pageToFetch = page ?? nextPage
        guard nextPage <= totalPages else { return }

        client.getProducts(in: category, sortedBy: sort, on: pageToFetch, searchText: searchText) { (success, failure) in
            completion?(success, failure)
            self.didLoadProducts(success: success, failure: failure)
        }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        addRefreshControl()
        client.getProducts(in: category, completion: didLoadProducts)
    }

    private func didLoadProducts(success: Response<Product>?, failure: Error?) {
        guard let response = success else {
            guard let error = failure else {
                logFailedPrecondition("Success and failure are nil")
                return
            }
            alert(for: error)
            return
        }

        products += response.items
        totalPages = response.totalPages
        nextPage = response.currentPage + 1

        collectionView?.reloadData()
    }
}

//MARK: - UICollectionViewDataSource

extension ProductListViewController: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath)

        guard let configurable = cell as? ProductViewModelConfigurable else {
            logFailedPrecondition("Internal inconsistency: cell is not configurable")
            return cell
        }
        guard let product = products.get(index: indexPath.item) else {
            logFailedPrecondition("Internal inconsistency: wrong number of items")
            return cell
        }

        configurable.configure(with: product)

        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ProductListViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let product = products.get(index: indexPath.item) else {
            logFailedPrecondition("Internal inconsistency: selected item no longer exists")
            return
        }

        selectedProduct = product
        performSegue(withIdentifier: "ProductDetailsViewController", sender: self)
    }

    public func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if indexPath.item == products.count - 1 && products.count > oldProductsCount {
            oldProductsCount = products.count
            loadMoreProducts()
        }
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.bounds.size.width

        let columns: CGFloat = width > 414 ? 3 : 2

        let side = width / columns

        return CGSize(width: side, height: side)
    }
}

//MARK: - Layout Transition

extension ProductListViewController {
    public override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
    }
}

//MARK: - Pull to Refresh
extension ProductListViewController {
    func addRefreshControl() {
        refreshControl.addTarget(self, action: #selector(ProductListViewController.pullToRefresh),
                                 for: .valueChanged)
        collectionView?.addSubview(refreshControl)
    }

    @objc func pullToRefresh() {
        cleanAndReload()
    }
}

//MARK: - Segue
extension ProductListViewController {
    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ProductDetailsViewController" else { return }

        guard let injectable = segue.destination as? ProductInjectable else {
            logFailedPrecondition("Segue is broken or ViewController is non-conformant")
            return
        }

        guard let selectedProduct = selectedProduct else {
            logFailedPrecondition("Internal inconsistency: product is misteriously nil")
            return
        }

        injectable.inject(product: selectedProduct)
    }
}
