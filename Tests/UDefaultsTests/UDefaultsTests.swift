import XCTest
@testable import UDefaults

final class UDefaultsTests: XCTestCase {
    func testString() {
        UserDefaults.standard.removePersistentDomain(forName: "testString")
        class MyDefaults: UDefaults {
            var userDefaults: UserDefaults = UserDefaults.init(suiteName: "testString")!
            private(set) lazy var string = UKey<String>(self, "string", defValue: "def")
        }
        let myDefaults = MyDefaults()
        XCTAssertEqual(myDefaults.string.value, "def")
        myDefaults.string.value = "qwerty"
        XCTAssertEqual(myDefaults.string.value, "qwerty")
    }
    
    func testStringMap() {
        UserDefaults.standard.removePersistentDomain(forName: "testStringMap")
        class MyDefaults: UDefaults {
            var userDefaults: UserDefaults = UserDefaults.init(suiteName: "testStringMap")!
            private(set) lazy var string = UMapKey<String>(self, "string", defValue: "def")
        }
        
        let myDefaults = MyDefaults()
        XCTAssertEqual(myDefaults.string["a"], "def")
        myDefaults.string["a"] = "qwerty"
        XCTAssertEqual(myDefaults.string["a"], "qwerty")
    }
    
    static var allTests = [
        ("testString", testString),
        ("testStringMap", testStringMap),
    ]
}
