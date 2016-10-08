import Foundation

public struct Response<T: InnerDecodable> {
    let from: Int
    let to: Int
    let currentPage: Int
    let totalPages: Int
    let items: [T]
}

extension Response: Decodable {
    public init?(dictionary: [String : Any]) {
        guard let _fromNumber   = dictionary["from"] as? NSNumber,
              let _toNumber     = dictionary["to"] as? NSNumber,
              let _currentPage  = dictionary["currentPage"] as? NSNumber,
              let _totalPages   = dictionary["totalPages"] as? NSNumber else {
                logFailedPrecondition("Response: Not all mandatory fields are present!")
                return nil
        }

        let _to                 = _toNumber.intValue
        let _from               = _fromNumber.intValue

        let _dictionaries = dictionary[T.arrayKey] as? [[String: Any]] ?? []
        let _items = _dictionaries.flatMap(T.init)

        if _items.count <= _to - _from {
            logFailedPrecondition("Response: not all items could be decoded")
        }

        from                    = _from
        to                      = _to
        currentPage             = _currentPage.intValue
        totalPages              = _totalPages.intValue
        items                   = _items

    }
}
