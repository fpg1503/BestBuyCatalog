import Alamofire

enum Sort: String {
    case salePriceAscending = "salePrice.asc"
    case salePriceDescending = "salePrice.dsc"
}

struct APIClient {
    let key: String
    let baseURL = "https://api.bestbuy.com/v1/"

    typealias ProductsCompletion = ([Product], Error?) -> Void
    func getProducts(in category: String,
                     sortedBy sort: Sort = .salePriceDescending,
                     on page: Int = 1,
                     pageSize: Int = 30,
                     completion: @escaping ProductsCompletion) {

        let searchString = "((categoryPath.id=\(category)))"
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
                case .success(let json):
                    let value = json as? [String: Any] ?? [:]
                    let dictionaries = value["products"] as? [[String: Any]] ?? []
                    let products = dictionaries.flatMap(Product.init)
                    completion(products, nil)
                case .failure(let error):
                    completion([], error)
                }
        }
    }
}
