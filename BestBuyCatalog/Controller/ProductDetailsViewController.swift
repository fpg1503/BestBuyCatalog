import UIKit

public final class ProductDetailsViewController: UIViewController, ProductInjectable {
    @IBOutlet var imageView: UIImageView?
    @IBOutlet private var productNameLabel: UILabel?
    @IBOutlet private var productDescriptionLabel: UILabel?
    @IBOutlet private var priceLabel: UILabel?

    var name: String?
    var shareURL: URL?

    private var product: Product? {
        didSet {
            if let product = product, product != oldValue {
                loadProduct()
            }
        }
    }

    func inject(product: Product) {
        self.product = product
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        loadProduct()
        addShareButton()
    }

    private func loadProduct() {
        guard let product = product else { return }

        if let imageURL = product.imageURL {
            imageView?.af_setImage(withURL: imageURL)
        } else {
            imageView?.image = UIImage(named: "no-image")
        }

        productNameLabel?.text = product.name
        productDescriptionLabel?.text = product.description
        priceLabel?.text = product.formattedPrice
        navigationItem.title = product.manufacturer

        name = product.name
        shareURL = product.url
    }
}
