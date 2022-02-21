import XCTest
@testable import TSKit_Core

class DebouncerTests: XCTestCase {
    
    private var debouncer: Debouncer!
    
    private var queue: DispatchQueue!
    
    override func setUp() {
        queue = .init(label: "TestingQueue")
        debouncer = .init(minimumDelay: 0.5, deafultQueue: queue)
        super.setUp()
    }
    
    func testDebouncer() {
        var values: [Int] = []
            
        let q = DispatchQueue(label: "Scheduler")
        let executeInSeconds = 1
        let iterations = 10
        let expectedValues = [iterations]
        let delay = (executeInSeconds * 1000)/iterations
        for i in (1...iterations) {
            q.asyncAfter(deadline: .now() + .milliseconds(i * delay)) { [self] in
                debouncer.debounce {
                    print("Using \(i)")
                    values.append(i)
                }
            }
        }
        q.asyncAfter(deadline: .now() + .milliseconds((executeInSeconds*2*1000))) {
            XCTAssertEqual(values, expectedValues)
        }
        
        wait(TimeInterval(executeInSeconds)*2.5)
    }
}

private extension DebouncerTests {
    
    /// Waits for a stub expectation that allows throttling test to wait until all throttling activity finishes.
    ///
    /// This method is used instead of expectations within throttling because throttling may vary at number of calls to the passed block, which will require similar code to be written for every test.
    func wait(_ time: TimeInterval = 2) {
        let expectation = self.expectation(description: "Waiting for debouncing to end")
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Int(time * 1000))) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: time + 0.1, handler: nil)
    }
}
