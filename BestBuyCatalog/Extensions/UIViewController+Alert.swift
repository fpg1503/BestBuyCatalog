import UIKit

extension UIViewController {
    func alert(for error: Error?, title: String = "Error") {
        let message = error?.localizedDescription ?? "Something unexpected happened, try again later."
        alert(with: message, title: title)
    }

    func alert(with message: String, title: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)

        alertController.addAction(ok)

        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
