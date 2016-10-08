import UIKit
import AlamofireImage

public final class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var productImageView: UIImageView?
    @IBOutlet private var discountLabelContainer: UIView?
    @IBOutlet private var discountLabel: UILabel?
    @IBOutlet private var productNameLabel: UILabel?
    @IBOutlet private var productPriceLabel: UILabel?

    @IBOutlet private var highlightView: UIView?
    override public var isHighlighted: Bool {
        didSet {
            guard let highlightView = highlightView else {
                logFailedPrecondition("No highlight view")
                return
            }

            let highlightedColor   = UIColor.lightGray.withAlphaComponent(0.3)
            let unhighlightedColor = UIColor.clear

            highlightView.backgroundColor = isHighlighted ? highlightedColor : unhighlightedColor
        }
    }

    func configure(with productViewModel: ProductViewModel) {
        productImageView?.image = nil

        if let image = productViewModel.thumbnailImageURL {
            productImageView?.af_setImage(withURL: image)
        } else {
            productImageView?.image = UIImage(named: "no-image")
        }

        discountLabelContainer?.isHidden = !productViewModel.onSale
        discountLabel?.text = productViewModel.formattedDiscount
        productNameLabel?.text = productViewModel.name
        productPriceLabel?.text = productViewModel.formattedPrice

        inferAccessibilityLabel(from: productViewModel.accessibilityLabel)
    }


    public override func prepareForReuse() {
        productImageView?.af_cancelImageRequest()
    }
}

extension ProductCollectionViewCell: ProductViewModelConfigurable { }
