import Foundation

public struct Product {
    let sku: Int
    let name: String
    let regularPrice: Double
    let salePrice: Double
    let onSale: Bool
    let url: URL?
    let shortDescription: String
    let longDescription: String
    let manufacturer: String

    let thumbnailImageURL: URL?
    let imageURL: URL?
}

extension Product: Decodable {
    public init?(dictionary: [String : Any]) {
        guard let _sku = dictionary["sku"] as? NSNumber,
              let _name = dictionary["name"] as? String,
              let _regularPrice = dictionary["regularPrice"] as? NSNumber,
              let _salePrice = dictionary["salePrice"] as? NSNumber,
              let _onSale = dictionary["onSale"] as? Bool,
              let _shortDescription = dictionary["shortDescription"] as? String,
              let _longDescription = dictionary["longDescription"] as? String,
              let _manufacturer = dictionary["manufacturer"] as? String else {
                logFailedPrecondition("Product: Not all mandatory fields are present!")
                return nil
        }

        let _url = dictionary["url"] as? String
        let _thumbnailImageURL = dictionary["thumbnailImage"] as? String
        let _imageURL = dictionary["image"] as? String


        sku                 = _sku.intValue
        name                = _name
        regularPrice        = _regularPrice.doubleValue
        salePrice           = _salePrice.doubleValue
        onSale              = _onSale
        url                 = _url.flatMap(URL.init(string: ))
        thumbnailImageURL   = _thumbnailImageURL.flatMap(URL.init(string: ))
        imageURL            = _imageURL.flatMap(URL.init(string: ))
        shortDescription    = _shortDescription
        longDescription     = _longDescription
        manufacturer        = _manufacturer
    }
}

extension Product: Hashable {
    public var hashValue: Int {
        return sku.hashValue
    }
}

public func ==(lhs: Product, rhs: Product) -> Bool {
    return  lhs.sku == rhs.sku &&
            lhs.name == rhs.name &&
            lhs.regularPrice == rhs.regularPrice &&
            lhs.salePrice == rhs.salePrice &&
            lhs.onSale == rhs.onSale &&
            lhs.url == rhs.url &&
            lhs.shortDescription == rhs.shortDescription &&
            lhs.longDescription == rhs.longDescription &&
            lhs.manufacturer == rhs.manufacturer &&
            lhs.thumbnailImageURL == rhs.thumbnailImageURL &&
            lhs.imageURL == rhs.imageURL
}
