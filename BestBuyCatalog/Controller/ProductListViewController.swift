import UIKit

public final class ProductListViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView?
    var products: [Product] = []

    private let client = APIClient()
    private let category = "abcat0401000"

    private var currentPage = 1
    private var totalPages = 1

    private func loadMoreProducts() {
        guard currentPage <= totalPages else { return }

        client.getProducts(in: category, on: currentPage, completion: didLoadProducts)
    }

    public override func viewDidLoad() {
        client.getProducts(in: category, completion: didLoadProducts)
    }

    private func didLoadProducts(success: ([Product], Int)?, failure: Error?) {
        guard let (receivedProducts, receivedTotalPages) = success else {
            //TODO: Alert for error!
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
