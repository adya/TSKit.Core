import XCTest
@testable import TSKit_Core

class ThrottlerTests: XCTestCase {
    
    private var throttler: Throttler!
    
    private var queue: DispatchQueue!
    
    override func setUp() {
        queue = .init(label: "TestingQueue")
        throttler = .init(throttlingInterval: 0.5, deafultQueue: queue)
        super.setUp()
    }

    func testThrottle() {
        var values: [Int] = []
            
        let q = DispatchQueue(label: "Scheduler")
        let executeInSeconds = 1
        let iterations = 10
//        let expectedValues = [1, 50, 51, 100] // For 100 iterations
        let expectedValues = [1, 5, 6, 10] // For 10 iterations
        let delay = (executeInSeconds * 1000)/iterations
        for i in (1...iterations) {
            q.asyncAfter(deadline: .now() + .milliseconds(i * delay)) { [self] in
                throttler.throttle {
                    values.append(i)
                }
            }
        }
        q.asyncAfter(deadline: .now() + .milliseconds((executeInSeconds*1000) + 200)) {
            XCTAssertEqual(values, expectedValues)
        }
        
        wait(TimeInterval(executeInSeconds)*1.5)
    }
    
    func testThrottleFirst() {
        var values: [Int] = []
            
        let q = DispatchQueue(label: "Scheduler")
        let executeInSeconds = 1
        let iterations = 10
//        let expectedValues = [1, 2, 51, 52] // For 100 iterations
        let expectedValues = [1, 2, 6, 7] // For 10 iterations
        let delay = (executeInSeconds * 1000)/iterations
        for i in (1...iterations) {
            q.asyncAfter(deadline: .now() + .milliseconds(i * delay)) { [self] in
                throttler.throttleFirst {
                    values.append(i)
                }
            }
        }
        q.asyncAfter(deadline: .now() + .milliseconds((executeInSeconds*1000) + 200)) {
            XCTAssertEqual(values, expectedValues)
        }
        
        wait(TimeInterval(executeInSeconds)*1.5)
    }
}


private extension ThrottlerTests {
    
    /// Waits for a stub expectation that allows throttling test to wait until all throttling activity finishes.
    ///
    /// This method is used instead of expectations within throttling because throttling may vary at number of calls to the passed block, which will require similar code to be written for every test.
    func wait(_ time: TimeInterval = 2) {
        let expectation = self.expectation(description: "Waiting for throttling to end")
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Int(time * 1000))) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: time + 0.1, handler: nil)
    }
}
