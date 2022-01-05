// - Since: 01/05/2022
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md
import Dispatch

/// **Not** reentrant synchronizer that is based on a concurrent `DispatchQueue`.
public final class ConcurrentQueueSynchronizer: AnySynchronizer {

    /// Unique value that identifies synchronizer's queue.
    ///
    /// This value is derived from the address (e.g. memory block allocated for synchornzier  is read as `Int`) of the synchronizer instance.
    private lazy var synchronizerContext = unsafeBitCast(self, to: Int.self)
    
    private var queue: DispatchQueue!

    /// - Parameter qos: Quality of service for underlying concurrent queue.
    public init(qos: DispatchQoS = .default) {
        queue = .init(label: "\(ConcurrentQueueSynchronizer.self).\(synchronizerContext)",
                      qos: qos,
                      attributes: .concurrent)
    }

    public func read<Result>(_ block: () throws -> Result) rethrows -> Result {
       try queue.sync(execute: block)
    }

    @discardableResult
    public func syncWrite<Result>(_ block: () throws -> Result) rethrows -> Result {
        try queue.sync(flags: .barrier, execute: block)
    }

    public func write(_ block: @escaping () -> Void) {
        queue.async(flags: .barrier, execute: block)
    }
}
