import XCTest
import Foundation
@testable import TSKit_Core

class DataSize_Tests: XCTestCase {
    
    var size = Data.Size()
    
    override func setUp() {
        size = Data.Size(terabytes: 0, gigabytes: 1023, megabytes: 1023, kilobytes: 1023, bytes: 1023)
    }
    
    func testWithoutOverflows() {
        
        XCTAssert(size.bytes == 1023)
        XCTAssert(size.kilobytes == 1023)
        XCTAssert(size.megabytes == 1023)
        XCTAssert(size.gigabytes == 1023)
        XCTAssert(size.terabytes == 0)
    }
}

