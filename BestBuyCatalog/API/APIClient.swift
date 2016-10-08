import Alamofire

enum Sort: String {
    case salePriceAscending = "salePrice.asc"
    case salePriceDescending = "salePrice.dsc"
}

struct APIClient {
    let key: String
    let baseURL = "https://api.bestbuy.com/v1/"

    typealias ProductsCompletion = (([Product], Int)?, Error?) -> Void
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
                case .success(let value):
                    let json = value as? [String: Any] ?? [:]
                    let dictionaries = json[Product.arrayKey] as? [[String: Any]] ?? []
                    let products = dictionaries.flatMap(Product.init)
                    completion((products, totalPages), nil)
                case .failure(let error):
                    completion(nil, error)
                }
        }
    }
}
