import UIKit

extension ProductDetailsViewController {
    func addShareButton() {
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(ProductDetailsViewController.showShareSheet))
        navigationItem.rightBarButtonItem = shareButton
    }

    func showShareSheet() {
        let activityViewController = UIActivityViewController(activityItems: [name, shareURL], applicationActivities: nil)

        activityViewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem

        present(activityViewController, animated: true)
    }
}
