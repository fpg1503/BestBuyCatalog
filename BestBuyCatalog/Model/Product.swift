import Foundation

struct Product {
    let sku: Int
    let productID: Int
    let name: String
    let regularPrice: Double
    let salePrice: Double
    let onSale: Bool
    let url: URL
    let shortDescription: String
    let longDescription: String
    let manufacturer: String

    let thumbnailImageURL: URL?
    let mediumImageURL: URL?
    let imageURL: URL?
}
