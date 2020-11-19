import XCTest
@testable import TSKit_Core

class ChainingTests: XCTestCase {
    
    private let expectedSteps = [0, 1]
    
    private var steps: [Int]!
    
    private var composition: (() -> Void)!
    
    override func setUp() {
        steps = []
        composition = expectedSteps.reduce({}) { res, step in res => { [self] in steps.append(step) } }
    }
    
    func testCompositionNotExecuted() {
        XCTAssertTrue(steps.isEmpty, "Composition operator should not be executed when composing")
    }
    
    func testCompositionExecutionOrder() {
        composition()
        XCTAssertEqual(steps, expectedSteps, "Composition operator should execute functions in the same order")
    }
}
