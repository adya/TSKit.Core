import XCTest
@testable import TSKit_Core

class String_JSON_Tests: XCTestCase {
    
    func testJSON() {
        let jsonString = "{\"int\" : 1, \"string\" : \"test\", \"json\": { \"int\" : 2 }}"
        
        let json = jsonString.dictionary
        let int = json?["int"] as? Int
        let string = json?["string"] as? String
        let innerJson = json?["json"] as? [String : Any]
        let innerInt = innerJson?["int"] as? Int
        
        XCTAssert(json != nil, "Failed to convert to dictionary.")
        XCTAssertEqual(int ?? 0, 1)
        XCTAssertEqual(innerInt ?? 0, 2)
        XCTAssertEqual(string, "test")
    }
}
