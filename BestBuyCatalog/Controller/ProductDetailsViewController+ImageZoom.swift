import UIKit

extension ProductDetailsViewController {
    @IBAction func showImage() {
        guard let imageView = imageView else { return }

        show(image: imageView.image, from: imageView)
    }
}
