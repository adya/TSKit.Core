import XCTest
import Foundation
@testable import TSKit_Core

class SynchronizerTests: XCTestCase {
    
    func testFlagReentranceDetectorInSerialSynchronizer() {
        let synchronizer = ReentrantSerialQueueSynchronizer(reentranceDetector: FlagReentranceDetector())
        expectNoDeadlocks(for: synchronizer)
    }
    
    func testFlagReentranceDetectorInSerialSynchronizerWithNestedQueues() {
        let synchronizer = ReentrantSerialQueueSynchronizer(reentranceDetector: FlagReentranceDetector())
        
        let queue = DispatchQueue(label: "Serial queue")
        expectNoDeadlocks(for: synchronizer, in: queue)
    }
    
    func testKeyReentranceDetectorInSerialSynchronizer() {
        let synchronizer = ReentrantSerialQueueSynchronizer(reentranceDetector: DispatchSpecificKeyReentranceDetector())
        expectNoDeadlocks(for: synchronizer)
    }
    
    func testKeyReentranceDetectorInConcurrentSynchronizer() {
        let synchronizer = ReentrantConcurrentQueueSynchronizer(reentranceDetector: DispatchSpecificKeyReentranceDetector())
        expectNoDeadlocks(for: synchronizer)
    }
}

private extension SynchronizerTests {
    
    func expectNoDeadlocks(for synchronizer: AnySynchronizer,
                           in queue: DispatchQueue? = nil) {
        expectNoDeadlocks(runs: 4) { [self] expectation in
            do {
                try assertNoDeadlock(in: synchronizer.read, synchronizer.read, within: queue, for: expectation)
                try assertNoDeadlock(in: synchronizer.read, synchronizer.syncWrite, within: queue, for: expectation)
                try assertNoDeadlock(in: synchronizer.syncWrite, synchronizer.read, within: queue, for: expectation)
                try assertNoDeadlock(in: synchronizer.syncWrite, synchronizer.syncWrite, within: queue, for: expectation)
            } catch {
                XCTFail("Synchronizer rethrown an error: \(error)")
            }
        }
    }
    
    func expectNoDeadlocks(runs: Int, _ block: @escaping (_ expectation: XCTestExpectation) -> Void) {
        let expectation = expectation( description: "Expected synchronizer to complete critical section without deadlocks")
        expectation.expectedFulfillmentCount = runs
        DispatchQueue.global().async {
            block(expectation)
        }
        waitForExpectations(timeout: 1)
    }
    
    func assertNoDeadlock(in access1: (_ block: () throws -> Void) throws -> Void,
                          _ access2: @escaping (_ block: () throws -> Void) throws -> Void,
                          within queue: DispatchQueue? = nil,
                          for expectation: XCTestExpectation) throws {
        try access1 {
            if let queue = queue {
                try queue.sync {
                    try access2 {
                        expectation.fulfill()
                    }
                }
            }
            else {
                try access2 {
                    expectation.fulfill()
                }
            }
        }
    }
}

class MockReentranceDetector: AnyConcurrentReentranceDetector {
    
    var isEntered: Bool = false
    
    var enterClosure: (() -> Bool)?
    
    var leaveClosure: (() -> Void)?
    
    func enter() -> Bool {
        enterClosure?() ?? true
    }
    
    func leave() {
        leaveClosure?()
    }
}
