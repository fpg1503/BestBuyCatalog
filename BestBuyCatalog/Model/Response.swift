import Foundation

public struct Response<T: Decodable> {
    let from: Int
    let to: Int
    let currentPage: Int
    let totalPages: Int
    let items: [T]
}
