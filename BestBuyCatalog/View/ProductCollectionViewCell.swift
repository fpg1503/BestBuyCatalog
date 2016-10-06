import UIKit

public final class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var productImageView: UIImageView?
    @IBOutlet private var discountLabelContainer: UIView?
    @IBOutlet private var discountLabel: UILabel?
    @IBOutlet private var productNameLabel: UILabel?
    @IBOutlet private var productPriceLabel: UILabel?
}
