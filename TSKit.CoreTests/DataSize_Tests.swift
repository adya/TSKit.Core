import XCTest
import Foundation
@testable import TSKit_Core

class DataSize_Tests: XCTestCase {
    
    var size = DataSize<Int64>()
    
    override func setUp() {
        size = DataSize(terabytes: 0, gigabytes: 1023, megabytes: 1023, kilobytes: 1023, bytes: 1023)
    }
}

// MARK: - Initializers
extension DataSize_Tests {
    
    func testWithoutOverflows() {
        
        XCTAssert(size.bytes == 1023)
        XCTAssert(size.kilobytes == 1023)
        XCTAssert(size.megabytes == 1023)
        XCTAssert(size.gigabytes == 1023)
        XCTAssert(size.terabytes == 0)
    }
    
    func testWithOverflows() {
        
        let overflownSize = DataSize(bytes: 2049)
        
        XCTAssert(overflownSize.bytes == 1)
        XCTAssert(overflownSize.kilobytes == 2)
        XCTAssert(overflownSize.megabytes == 0)
        XCTAssert(overflownSize.gigabytes == 0)
        XCTAssert(overflownSize.terabytes == 0)
    }
    
}

// MARK: - Sum
extension DataSize_Tests {
    
    
    func testSumWithoutOverflow() {
        
        let size1 = DataSize(bytes: 200)
        let size2 = DataSize(megabytes: 10, bytes: 300)
        
        
        let sum = size1 + size2
        
        XCTAssert(sum.bytes == 500)
        XCTAssert(sum.kilobytes == 0)
        XCTAssert(sum.megabytes == 10)
        XCTAssert(sum.gigabytes == 0)
        XCTAssert(sum.terabytes == 0)
    }
    
    func testMutatingSumWithoutOverflow() {
        
        var size1 = DataSize(bytes: 200)
        let size2 = DataSize(megabytes: 10, bytes: 300)
                
        size1 += size2
        
        XCTAssert(size1.bytes == 500)
        XCTAssert(size1.kilobytes == 0)
        XCTAssert(size1.megabytes == 10)
        XCTAssert(size1.gigabytes == 0)
        XCTAssert(size1.terabytes == 0)
    }
    
    func testSumWithOverflow() {
        
        let size1 = DataSize(bytes: 1000)
        let size2 = DataSize(kilobytes: 10, bytes: 25)
        
        
        let sum = size1 + size2
        
        XCTAssert(sum.bytes == 1)
        XCTAssert(sum.kilobytes == 11)
        XCTAssert(sum.megabytes == 0)
        XCTAssert(sum.gigabytes == 0)
        XCTAssert(sum.terabytes == 0)
    }
    
    func testMutatingSumWithOverflow() {
        
        var size1 = DataSize(bytes: 1000)
        let size2 = DataSize(megabytes: 10, kilobytes: 10, bytes: 25)
        
        size1 += size2
        
        XCTAssert(size1.bytes == 1)
        XCTAssert(size1.kilobytes == 11)
        XCTAssert(size1.megabytes == 10)
        XCTAssert(size1.gigabytes == 0)
        XCTAssert(size1.terabytes == 0)
    }
}
