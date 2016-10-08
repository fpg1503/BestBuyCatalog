import UIKit

protocol AccessibleElement: class {
    var isAccessibilityElement: Bool { get set }
    var accessibilityLabel: String? { get set }
    var accessibilityHint: String? { get set }
    var accessibilityValue: String? { get set }
    var accessibilityTraits: UIAccessibilityTraits { get set }
    var accessibilityFrame: CGRect { get set }
}

extension UIView: AccessibleElement { }

extension AccessibleElement {
    func inferAccessibilityLabel(from elements: [AccessibleElement]) {
        guard elements.count > 0 else { return }
        let accessibilityLabels = elements.map { $0.accessibilityLabel }.flatMap { $0 }
        inferAccessibilityLabel(from: accessibilityLabels.joined(separator: " "))
    }

    func inferAccessibilityLabel(from label: String) {
        guard !label.isEmpty else { return }
        accessibilityLabel = label
        isAccessibilityElement = true
    }
}
