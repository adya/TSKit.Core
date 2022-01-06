// - Since: 01/05/2022
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

import Dispatch

/// **Not** reentrant synchronizer that is based on a serial `DispatchQueue`.
public final class SerialQueueSynchronizer: QueueSynchronizer {

    /// **Not** reentrant synchronizer that is based on a serial `DispatchQueue`.
    /// - Parameter qos: Quality of service for underlying concurrent queue.
    public init(qos: DispatchQoS = .default) {
        super.init(qos: qos)
    }
}

/// Reentrant synchronizer that is based on a serial `DispatchQueue`.
///
/// Reentrant synchronizers handle nested calls to `read` and `syncWrite`,
/// so that they won't cause deadlocks. Use reentrant synchronizers when you need to recursively call synchronized API.
/// For example:
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
///     // This will cause a dead-lock when used with non-reentrant synchronizers.
///     // But will work as intended when used with reentrant synchronizers.
///         synchornizedRoutine2()
///     }
/// }
/// ```
public final class ReentrantSerialQueueSynchronizer: QueueSynchronizer {
    
    /// **Not** reentrant synchronizer that is based on a serial `DispatchQueue`.
    /// - Parameter qos: Quality of service for underlying concurrent queue.
    /// - Parameter reentranceDetector: Detector that will handle reentrance behavior. Defaults to `DispatchSpecificKeyReentranceDetector`.
    public init(qos: DispatchQoS = .default,
                reentranceDetector: AnyReentranceDetector = DispatchSpecificKeyReentranceDetector()) {
        super.init(qos: qos,
                   reentranceDetector: reentranceDetector)
    }
}
