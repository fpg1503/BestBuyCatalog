import UIKit
import JTSImageViewController

extension UIViewController {
    func show(image: UIImage?, from view: UIView, mode: JTSImageViewControllerMode = .image, backgroundStyle: JTSImageViewControllerBackgroundOptions = .scaled, transition: JTSImageViewControllerTransition = .fromOriginalPosition) {

        let imageInfo = JTSImageInfo()
        imageInfo.image = image
        imageInfo.referenceRect = view.frame
        imageInfo.referenceView = view

        let imageViewer = JTSImageViewController(imageInfo: imageInfo, mode: mode, backgroundStyle: backgroundStyle)

        imageViewer?.show(from: self, transition: transition)
    }
}
