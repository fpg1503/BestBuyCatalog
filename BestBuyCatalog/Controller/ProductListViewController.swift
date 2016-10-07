import UIKit

public final class ProductListViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView?

    var products: [Product] = []
}

extension ProductListViewController: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //TODO
        return UICollectionViewCell()
    }
}
