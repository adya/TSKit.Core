// - Since: 02/19/2022
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

import Foundation

/// Debouncer executes the block after the specified time interval elapses between calls.
///
/// Use the `Debouncer` to control the number of calls and time between execution of these calls.
/// This works similarly to Combine's `debounce` method of a `Publisher`.
/// - Important: Do not use the same instance of `Debouncer` to debounce rapidly firing events in multiple places.
///              Each place should be handled by a separate `Debouncer` instance, otherwise they'll interfere.
/// - Seealso: Throttler.
open class Debouncer {

    private let queue: DispatchQueue

    /// A minimum number of seconds that must elapse since last call in order to trigger the latest call.
    public var minimumDelay: TimeInterval

    private var workItem: DispatchWorkItem = .init(block: {})
    
    private let synchronizingQueue = DispatchQueue(label: "DebouncerSynchronizationQueue")

    /// - Parameter minimumDelay: A minimum number of seconds that must elapse since last call in order to trigger the latest call.
    /// - Parameter defaultQueue: A `DispatchQueue` on which blocks will be called. You may overwrite the queue in `debounce` method.
    public init(minimumDelay: TimeInterval, deafultQueue: DispatchQueue = .global(qos: .utility)) {
        self.minimumDelay = minimumDelay
        self.queue = deafultQueue
    }

    /// Debounces execution of a given `block`.
    ///
    /// Use `debounce` to control the number of calls and time between execution of these calls.
    /// When the calling code rapidly calls `debounce` only the `block` passed to the latest `debounce` call will be executed when `minimumDelay` will elapse.
    /// - Important: If the rating at which new calls coming to `debouncer` exactly matches its `minimumDelay`,
    ///              the quality of service of the used `DispatchQueue` will affect number of debounced calls.
    ///              For example, the lower quality of service will cause more calls to be debounced at `minimumDealy`.
    /// - Parameter queue: An optional custom `DispatchQueue` on which given `block` will be executed.
    ///                    If not specified `debounce` will use the `queue` provided during initialization of the `Debouncer`.
    /// - Parameter block: The block that will be executed after `minimumDelay` sincle last debounce.
    public func debounce(on queue: DispatchQueue? = nil, _ block: @escaping () -> Void) {
        workItem.cancel()
        workItem = DispatchWorkItem(block: block)
        
        let preferredQueue = queue ?? self.queue
        preferredQueue.asyncAfter(deadline: .now() + minimumDelay, execute: workItem)
    }
}
