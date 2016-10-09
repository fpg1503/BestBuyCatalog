import UIKit

//MARK: - Sort

extension ProductListViewController {
    @IBAction func showSortSelector() {
        let alertController = UIAlertController(title: "Sorting.Title".localized, message: "Sorting.Message".localized, preferredStyle: .actionSheet)

        let priceAscending = UIAlertAction(title: "Sorting.PriceAscending.Title".localized, style: .default) { _ in
            self.sort = .salePriceAscending
        }

        let priceDescending = UIAlertAction(title: "Sorting.PriceDescending.Title".localized, style: .default) { _ in
            self.sort = .salePriceDescending
        }

        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil)

        alertController.addAction(priceAscending)
        alertController.addAction(priceDescending)
        alertController.addAction(cancel)

        alertController.popoverPresentationController?.permittedArrowDirections = [.up]
        alertController.popoverPresentationController?.barButtonItem = navigationItem.leftBarButtonItem

        present(alertController, animated: true, completion: nil)
    }
}
