import UIKit
import AlamofireImage

public final class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var productImageView: UIImageView?
    @IBOutlet private var discountLabelContainer: UIView?
    @IBOutlet private var discountLabel: UILabel?
    @IBOutlet private var productNameLabel: UILabel?
    @IBOutlet private var productPriceLabel: UILabel?

    func configure(with productViewModel: ProductViewModel) {
        if let image = productViewModel.thumbnailImageURL {
            productImageView?.af_setImage(withURL: image)
        } else {
            logFailedPrecondition("Product has no image")
        }

        discountLabelContainer?.isHidden = !productViewModel.onSale
        discountLabel?.text = productViewModel.formattedDiscount
        productNameLabel?.text = productViewModel.name
        productPriceLabel?.text = productViewModel.formattedPrice

        //TODO: Accessibility!
    }
}

extension ProductViewModelConfigurable { }
