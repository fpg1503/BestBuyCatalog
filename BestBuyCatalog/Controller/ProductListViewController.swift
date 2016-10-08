import UIKit

public final class ProductListViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView?
    var products: [Product] = []

    private let client = APIClient()
    private let category = "abcat0401000"

    private var currentPage = 0
    private var totalPages = 1

    var oldProductsCount = 0

    func loadMoreProducts() {
        guard currentPage + 1 <= totalPages else { return }

        currentPage += 1
        client.getProducts(in: category, on: currentPage, completion: didLoadProducts)
    }

    public override func viewDidLoad() {
        client.getProducts(in: category, completion: didLoadProducts)
    }

    private func didLoadProducts(success: ([Product], Int)?, failure: Error?) {
        guard let (receivedProducts, receivedTotalPages) = success else {
            guard let error = failure else {
                logFailedPrecondition("Success and failure are nil")
                return
            }
            alert(for: error)
            return
        }

        products += receivedProducts
        totalPages = receivedTotalPages

        collectionView?.reloadData()
    }
}

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

extension ProductListViewController {
    public override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
    }
}
