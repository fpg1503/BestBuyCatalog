import UIKit

extension UIViewController {
    func alert(for error: Error?, title: String = "Alert.Title.Error".localized) {
        let message = error?.localizedDescription ?? "Alert.Message.Unexpected".localized
        alert(with: message, title: title)
    }

    func alert(with message: String, title: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let ok = UIAlertAction(title: "Alert.Ok".localized, style: .default, handler: nil)

        alertController.addAction(ok)

        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
