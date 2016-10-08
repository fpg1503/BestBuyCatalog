import Foundation

public protocol Decodable {
    init?(dictionary: [String: Any])
}

public protocol InnerDecodable: Decodable {
    static var arrayKey: String { get }
}
