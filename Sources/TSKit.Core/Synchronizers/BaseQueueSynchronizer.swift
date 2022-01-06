// - Since: 01/05/2022
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

import Dispatch

/// Base synchronizer that other `DispatchQueue`-based synchronizer inherit.
///
/// Default behavior is `NonReentrantSerialQueueSynchronizer`.
public class QueueSynchronizer: AnySynchronizer {
    
    private(set) var queue: DispatchQueue!
    
    private(set) var flags: DispatchWorkItemFlags

    private let reentranceDetector: AnyReentranceDetector
    
    init(qos: DispatchQoS,
         attributes: DispatchQueue.Attributes = [],
         reentranceDetector: AnyReentranceDetector = NonReentrantDetector()) {
        self.flags = attributes.contains(.concurrent) ? .barrier : []
        self.reentranceDetector = reentranceDetector
        self.queue = .init(label: "\(self)", qos: qos, attributes: attributes)
        
        if let detector = reentranceDetector as? AnyDispatchQueueAttachable {
            detector.attach(queue)
        }
    }
    
    public func read<Result>(_ block: () throws -> Result) rethrows -> Result {
        guard reentranceDetector.enter() else { return try block() }
        defer { reentranceDetector.leave() }
        return try queue.sync(execute: block)
    }

    @discardableResult
    public func syncWrite<Result>(_ block: () throws -> Result) rethrows -> Result {
        guard reentranceDetector.enter() else { return try block() }
        defer { reentranceDetector.leave() }
        return try queue.sync(flags: flags, execute: block)
    }

    public func write(_ block: @escaping () -> Void) {
        queue.async(flags: flags, execute: block)
    }
}
