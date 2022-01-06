// - Since: 01/06/2022
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

import Dispatch

/// An object that detects nested attempts to enter the same synchronized scope.
///
/// `AnyReentrantSynchronizer`s use detectors to handle cases when synchronizer attempts to synchronize within already synchronized scope, that would cause deadlocks otherwise.
/// - Important: `AnyReentrantSynchronizer` **does not** guarantee that it will work in concurrent synchronizers. When using such synchronizers, refer to `AnyConcurrentReentranceDetector`.
public protocol AnyReentranceDetector {
    
    /// Checks whether detector has already detected previous entrance.
    ///
    /// This flag is `false` when either there were no `enter()` calls or they were paired with `leave()` calls.
    /// - Note: Some implementations of reentrance might be
    var isEntered: Bool { get }
    
    /// Attempts to enter the scope of synchronization.
    ///
    /// Entrance fails if there is already active entrance.
    /// - Returns: Flag indicating whether entrance is successful.
    func enter() -> Bool
    
    /// Leaves previously entered scope of synchronization.
    func leave()
}

/// An object that detects nested attempts to enter the same synchronized scope.
///
/// `AnyConcurrentReentranceDetector`s use detectors to handle cases when synchronizer attempts to synchronize within already synchronized scope, that would cause deadlocks otherwise.
/// - Important: `AnyConcurrentReentranceDetector` is used with concurrent synchronizers.
public protocol AnyConcurrentReentranceDetector: AnyReentranceDetector {}

/// An object that is attachable to `DispatchQueue`.
///
/// `AnyDispatchQueueAttachable` is a trait of `AnyReentranceDector`s that needs synchronizer's `DispatchQueue`.
public protocol AnyDispatchQueueAttachable {
    
    /// Attaches itself to a given `queue` in order to track reentrance.
    ///
    /// `QueueSynchronizer`s automatically call this method on `AnyReentranceDector`s that conform to `AnyDispatchQueueAttachable`.
    func attach(_ queue: DispatchQueue)
}
