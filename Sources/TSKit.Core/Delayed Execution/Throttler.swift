// - Since: 02/19/2022
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

import Foundation

/// Throttler executes either the most recent or the first submitted block once within the specified time interval.
///
/// Use the `Throttler` to selectively execute one of the calls received during an interval you specify. All other calls received in the throttling interval are not executed.
/// This works similarly to Combine's `throttle` method of a `Publisher`.
/// - Important: Do not use the same instance of `Throttler` to throttle rapidly firing events in multiple places.
///              Each place should be handled by a separate `Throttler` instance, otherwise they'll interfere.
/// - Seealso: Debouncer.
open class Throttler {
    
    private let queue: DispatchQueue

    /// A minimum number of seconds that must elapse before triggering either the most recent or the first call submitted to `throttle` or `throttleFirst` respectively.
    public var throttlingInterval: TimeInterval {
        didSet {
            throttlingMilliseconds = Int(throttlingInterval * 1000)
        }
    }
    
    private var throttlingMilliseconds: Int
    
    /// The work item that will be executed at the end of throttling.
    private var currentWorkItem: DispatchWorkItem?
    
    /// The first work item submitted to the throttler. It will be immediately executed before starting throttling routine.
    private var initiallySubmittedWorkItem: DispatchWorkItem?
    
    private var isThrottling = false
    
    private let synchronizingQueue = DispatchQueue(label: "ThrottlerSynchronizationQueue")
    
    /// - Parameter throttlingInterval: A minimum number of seconds that must elapse before triggering either the most recent or the first call submitted to `throttle` or `throttleFirst` respectively.
    /// - Parameter defaultQueue: A `DispatchQueue` on which blocks will be called. You may overwrite the queue in `throttle` methods.
    public init(throttlingInterval: TimeInterval, deafultQueue: DispatchQueue = .global(qos: .utility)) {
        self.throttlingInterval = throttlingInterval
        self.throttlingMilliseconds = Int(throttlingInterval * 1000)
        self.queue = deafultQueue
    }
    
    /// Throttles execution of a given `block` and executes only the most recent `block` submitted to `throttle` within the current throttling interval.
    ///
    /// Use the `throttle` to selectively execute the most recent `block` received during a throttling interval you specified.
    /// When the calling code rapidly calls `throttle` only the `block` passed to the latest `throttle` call will be executed when current throttling interval will elapse.
    /// - Attention: The first call to `throttle` that initiaes throttling will immediately execute given `block` and start throttling all subsequent calls.
    /// - Note: If no other calls will be received during throttling interval, the throttling will silently end without calling the same block.
    ///         In this case it means that `Thorttler` is configured with longer throttling interval than the frequency at which calls actually occur.
    /// - Parameter queue: An optional custom `DispatchQueue` on which given `block` will be executed.
    ///                    If not specified `throttle` will use the `queue` provided during initialization of the `Throttler`.
    /// - Parameter block: The block that will be executed at the end o current throttling interval defined by `throttlingInterval`.
    public func throttle(on queue: DispatchQueue? = nil, _ block: @escaping () -> Void) {
        synchronizingQueue.sync {
            currentWorkItem = DispatchWorkItem(block: block)
            if initiallySubmittedWorkItem == nil {
                initiallySubmittedWorkItem = currentWorkItem
            }
        }
        let preferredQueue = queue ?? self.queue
        
        startThrottling(on: preferredQueue)
    }
    
    /// Throttles execution of a given `block` and executes only the first `block` submitted to `throttleFirst` within the current throttling interval.
    ///
    /// Use the `throttleFirst` to selectively execute the first `block` received during a throttling interval you specified.
    /// When the calling code rapidly calls `throttleFirst` only the `block` passed to the first `throttleFFirst` call will be executed when current throttling interval will elapse.
    /// - Attention: The first call to `throttleFirst` that initiaes throttling will immediately execute given `block` and start throttling all subsequent calls.
    /// - Note: If no other calls will be received during throttling interval, the throttling will silently end without calling the same block.
    ///         In this case it means that `Thorttler` is configured with longer throttling interval than the frequency at which calls actually occur.
    /// - Parameter queue: An optional custom `DispatchQueue` on which given `block` will be executed.
    ///                    If not specified `throttle` will use the `queue` provided during initialization of the `Throttler`.
    /// - Parameter block: The block that will be executed at the end o current throttling interval defined by `throttlingInterval`.
    public func throttleFirst(on queue: DispatchQueue? = nil, _ block: @escaping () -> Void) {
        synchronizingQueue.sync {
            let item = DispatchWorkItem(block: block)
            if initiallySubmittedWorkItem == nil {
                initiallySubmittedWorkItem = item
            } else if currentWorkItem == nil {
                currentWorkItem = item
            }
        }
        let preferredQueue = queue ?? self.queue
        
        startThrottling(on: preferredQueue)
    }
    
    private func startThrottling(on queue: DispatchQueue) {
        synchronizingQueue.sync {
            guard !isThrottling else { return }
            isThrottling = true
            
            queue.sync {
                self.initiallySubmittedWorkItem?.perform()
            }
            
            synchronizingQueue.asyncAfter(deadline: .now() + .milliseconds(throttlingMilliseconds)) { [weak self] in
                self?.execute(on: queue)
                self?.isThrottling = false
            }
        }
    }
    
    private func execute(on queue: DispatchQueue) {
        // Execute current `workItem` if it isn't the same as the one
        // that initiated throttling.
        if let workItem = currentWorkItem,
           workItem !== initiallySubmittedWorkItem {
            queue.sync {
                workItem.perform()
            }
        }
        self.initiallySubmittedWorkItem = nil
        self.currentWorkItem = nil
    }
}
