import UIKit

protocol ProductViewModelConfigurable {
    func configure(with productViewModel: ProductViewModel)
}

protocol ProductViewModel {
    var onSale: Bool { get }
    var formattedDiscount: String { get }
    var formattedPrice: String { get }
    var name: String { get }
    var thumbnailImageURL: URL? { get }

    var accessibilityLabel: String { get }
}
