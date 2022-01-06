// - Since: 01/06/2022
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

/// Reentrance detector that is based on a `Bool` flag  to detect when synchronizer is called within the same synchronized block.
///
/// Detecting reentrance using `Bool` flag is possible only in *serial* sycnhronizers.
/// It also supports configuration when there are nested `DispatchQueue`s that are synchronously called within synchronized block,
/// and attempt to access the same synchronized section:
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
public class FlagReentranceDetector: AnyReentranceDetector {
    
    @Synchronized(synchronizer: ConcurrentQueueSynchronizer())
    public private(set) var isEntered: Bool = false
    
    public init() {}
    
    public func enter() -> Bool {
        guard !isEntered else { return false }
        isEntered = true
        return true
    }
    
    public func leave() {
        isEntered = false
    }
}
