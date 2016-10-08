import UIKit

public final class ProductListViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView?
    var products: [Product] = []

    private let client = APIClient()
    private let category = "abcat0401000"

    private var nextPage = 1
    private var totalPages = 1

    var oldProductsCount = 0

    let refreshControl = UIRefreshControl()

    func cleanAndReload() {
        loadMoreProducts(page: 1) { (success, _) in
            self.refreshControl.endRefreshing()
            if success != nil {
                self.nextPage = 1
                self.oldProductsCount = 0
                self.products = []
            }
        }
    }

    typealias ProductsCompletion = (Response<Product>?, Error?) -> Void
    func loadMoreProducts(page: Int? = nil, completion: ProductsCompletion? = nil) {
        let pageToFetch = page ?? nextPage
        guard nextPage <= totalPages else { return }

        client.getProducts(in: category, on: pageToFetch) { (success, failure) in
            completion?(success, failure)
            self.didLoadProducts(success: success, failure: failure)
        }
    }

    public override func viewDidLoad() {
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
