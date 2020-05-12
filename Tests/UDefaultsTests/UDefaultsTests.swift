import XCTest
@testable import UDefaults

final class UDefaultsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(UDefaults().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
