import Alamofire

enum Sort: String {
    case salePriceAscending = "salePrice.asc"
    case salePriceDescending = "salePrice.dsc"
}

struct APIClient {
    let key: String
    let baseURL = "https://api.bestbuy.com/v1/"

    typealias ProductsCompletion = (Response<Product>?, Error?) -> Void
    func getProducts(in category: String,
                     sortedBy sort: Sort = .salePriceDescending,
                     on page: Int = 1,
                     pageSize: Int = 30,
                     searchText: String? = nil,
                     completion: @escaping ProductsCompletion) {


        let disallowed = CharacterSet.alphanumerics.inverted
        let clearSearch = searchText?.components(separatedBy: disallowed)
                                     .joined(separator: "")
                                     .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let shouldSearch = !clearSearch.isEmpty

        let search = shouldSearch ? "(search=\(clearSearch))&" : ""
        let category = "(categoryPath.id=\(category))"
        let searchString = "(\(search)\(category))"
        let endpoint = baseURL + "products" + searchString

        let parameters = ["apiKey": key,
                          "format": "json",
                          "sort": sort.rawValue,
                          "pageSize": pageSize,
                          "page": page] as [String : Any]

        Alamofire.request(endpoint, method: .get, parameters: parameters)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = value as? [String: Any] ?? [:]
                    let reponse = Response<Product>(dictionary: json)
                    completion(reponse, nil)
                case .failure(let error):
                    completion(nil, error)
                }
        }
    }
}
