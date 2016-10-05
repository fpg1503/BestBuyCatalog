import XCTest
import Mockingjay
@testable import BestBuyCatalog

class APIClientTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        let path = URL(fileURLWithPath: Bundle(for: type(of: self)).path(forResource: "Products", ofType: "json")!)
        let data = try! Data(contentsOf: path)
        stub(everything, jsonData(data))
    }

    func testGetProducts() {
        let client = APIClient(key: "")

        let testExpectation = expectation(description: "Fake request")

        client.getProducts(in: "") { (response, error) in
            XCTAssertNotNil(response)
            let (products, pages) = response!
            XCTAssertNil(error)
            XCTAssertEqual(products.count, 100)
            XCTAssertEqual(pages, 4)
            testExpectation.fulfill()
        }

        waitForExpectations(timeout: 30, handler: nil)
    }
    
}
