import UIKit

protocol ProductViewModelConfigurable {
    func configure(with productViewModel: ProductViewModel)
}

protocol ProductInjectable {
    func inject(product: Product)
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

        let lowDiscount = discountPercentage < 10
        let formattedPercentage = String(format: "-%d%%", Int(discountPercentage))
        return lowDiscount ? "Sale!" : formattedPercentage
    }

    var formattedPrice: String {
        let formatter = NumberFormatter.currencyFormatter()
        let formattedRegularPrice = formatter.string(from: NSNumber(value: regularPrice)) ?? ""
        let formattedSalePrice = formatter.string(from: NSNumber(value: salePrice)) ?? ""

        if onSale && salePrice < regularPrice {
            return String(format: "ProductCell.Discount".localized, formattedRegularPrice, formattedSalePrice)
        } else {
            return formattedSalePrice
        }
    }

    var accessibilityLabel: String {
        let sale = onSale ? "ProductCell.Accessibility.OnSale".localized : " "
        return name + sale + formattedPrice
    }

    var description: String {
        if !longDescription.isEmpty {
            return longDescription
        }
        return shortDescription
    }
}
