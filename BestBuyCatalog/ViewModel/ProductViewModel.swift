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

extension Product: ProductViewModel {
    var thumbnailImageURL: URL? {
        return imageURL
    }

    var formattedDiscount: String {
        let discount = regularPrice - salePrice
        let discountPercentage = (discount/regularPrice) * 100

        return String(format: "%2f%%", discountPercentage)
    }

    var formattedPrice: String {
        let formatter = NumberFormatter.currencyFormatter()
        let formattedRegularPrice = formatter.string(from: NSNumber(value: regularPrice)) ?? ""
        let formattedSalePrice = formatter.string(from: NSNumber(value: salePrice)) ?? ""

        if onSale && salePrice < regularPrice {
            return "De " + formattedRegularPrice + " por: " + formattedSalePrice
        } else {
            return formattedSalePrice
        }
    }

    var accessibilityLabel: String {
        let sale = onSale ? " Em promoção: " : " "
        return name + sale + formattedPrice
    }
}
