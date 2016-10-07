import UIKit

public extension UIView {
    @IBInspectable public var borderRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.masksToBounds = newValue > 0
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable public var borderColor: UIColor? {
        get {
            return layer.borderColor.map(UIColor.init(cgColor:))
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
