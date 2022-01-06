// - Since: 01/06/2022
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

import Dispatch

/// Reentrance detector that uses `DispatchSpecificKey` to detect when synchronizer is called within the same `DispatchQueue`.
///
/// Detecting reentrance using `DispatchSpecificKey` supports concurrent synchronizers,
/// but only guarantees that there will be no direct entrances to the same synchronizer's `DispatchQueue`.
///
/// - Important: This method fails in a more complex configuration. For example, when a `DispatchQueue` is synchronously called within synchronized block,
///              and attempts to also access synchronized section, `DispatchSpecificKeyReentranceDetector` won't detect such reentrance, thus leading to a deadlock:
/// ```
/// let synchronizer: AnySynchronizer
///
/// func synchornizedRoutine1(_ synchronizedCompletion: () -> Void) {
///     synchronizer.read {
///         // perform some reading routine
///         synchronizedCompletion()
///     }
/// }
///
/// func synchornizedRoutine2() {
///     synchronizer.syncWrite {
///         // perform some writing routine
///     }
/// }
/// func call() {
///     synchornizedRoutine1 {
///     // This will cause a dead-lock when used with `DispatchSpecificKeyReentranceDetector`.
///     // But will work as intended when used with `FlagReentranceDetector`.
///         DispatchQueue.main.sync {
///             synchornizedRoutine2()
///         }
///     }
/// }
/// ```
/// In such cases you can use `FlagReentranceDetector` on a `ReentrantSerialQueueSynchronizer`.
public class DispatchSpecificKeyReentranceDetector: AnyConcurrentReentranceDetector,
                                                    AnyDispatchQueueAttachable {
    
    /// Key attached to the `queue` that will be used to identify it when performing `read` and `syncWrite` operations.
    private static let synchronizerKey = DispatchSpecificKey<Int>()

    /// Key attached to the `queue` that will be used to identify it when performing `read` and `syncWrite` operations.
    private var synchronizerKey: DispatchSpecificKey<Int> { DispatchSpecificKeyReentranceDetector.synchronizerKey }

    /// Unique value that identifies synchronizer's queue.
    ///
    /// This value is derived from the address (e.g. memory block allocated for synchornzier  is read as `Int`) of the synchronizer instance.
    private lazy var synchronizerContext = unsafeBitCast(self, to: Int.self)
    
    public var isEntered: Bool {
        DispatchQueue.getSpecific(key: synchronizerKey) == synchronizerContext
    }
    
    public init() {}
    
    public func enter() -> Bool {
        !isEntered
    }
    
    public func leave() {}
    
    public func attach(_ queue: DispatchQueue) {
        queue.setSpecific(key: synchronizerKey, value: synchronizerContext)
    }
}
