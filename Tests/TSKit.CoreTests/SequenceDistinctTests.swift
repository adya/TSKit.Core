import XCTest
@testable import TSKit_Core

class SequenceDistinctTests: XCTestCase {
    
    func testDistinctFirstReturnsSameArrayWhenAllElementsDistinct() {
        let elements = [1,2,3,4,5,6,7].asItems
        XCTAssertEqual(elements.names, elements.distinctFirst.names)
    }
    
    func testDistinctFirstRemovesDuplicates() {
        let elements = [1,2,3,4,5,5,2].asItems
        let distinct = Array(elements.dropLast(2))
        XCTAssertEqual(distinct.names, elements.distinctFirst.names)
    }
    
    func testDistinctFirstReturnsSameArrayWhenAllKeysDistinct() {
        let elements = [1,2,3,4,5,6,7].asItems
        XCTAssertEqual(elements.names, elements.distinctFirst(by: { $0.id }).names)
    }
    
    func testDistinctFirstRemovesDuplicatedKeys() {
        let elements = [1,2,3,4,5,5,2].asItems
        let distinct = Array(elements.dropLast(2))
        XCTAssertEqual(distinct.names, elements.distinctFirst(by: { $0.id }).names)
    }
    
    func testDistinctLastReturnsSameArrayWhenAllElementsDistinct() {
        let elements = [1,2,3,4,5,6,7].asItems
        XCTAssertEqual(elements.names, elements.distinctLast.names)
    }
    
    func testDistinctLastRemovesDuplicates() {
        let elements = [1,2,3,4,5,5,2].asItems
        let distinct = elements.removing(at: 4)
                               .removing(at: 1)
        XCTAssertEqual(distinct.names, elements.distinctLast.names)
    }
    
    func testDistinctLastReturnsSameArrayWhenAllKeysDistinct() {
        let elements = [1,2,3,4,5,6,7].asItems
        XCTAssertEqual(elements.names, elements.distinctLast(by: { $0.id }).names)
    }
    
    func testDistinctLastRemovesDuplicatedKeys() {
        let elements = [1,2,3,4,5,5,2].asItems
        let distinct = elements.removing(at: 4)
                               .removing(at: 1)
        XCTAssertEqual(distinct.names, elements.distinctLast(by: { $0.id }).names)
    }
}

struct Item: Equatable {
    
    let name: String
    
    let id: Int
    
    static func == (_ lhs: Item, _ rhs: Item) -> Bool {
        lhs.id == rhs.id
    }
}

extension Array where Element == Int {
    
    var asItems: [Item] {
        enumerated().map { Item(name: "\($0.offset + 1)", id: $0.element) }
    }
}

extension Array where Element == Item {
    
    var names: [String] { map { $0.name } }
}
