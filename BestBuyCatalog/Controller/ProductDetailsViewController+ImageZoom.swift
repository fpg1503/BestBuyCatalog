import UIKit
import JTSImageViewController

extension ProductDetailsViewController {
    @IBAction func showImage() {
        guard let imageView = imageView else { return }

        let imageInfo = JTSImageInfo()
        imageInfo.image = imageView.image
        imageInfo.referenceRect = imageView.frame
        imageInfo.referenceView = imageView

        let imageViewer = JTSImageViewController(imageInfo: imageInfo, mode: .image, backgroundStyle: .scaled)

        imageViewer?.show(from: self, transition: .fromOriginalPosition)
    }
}
