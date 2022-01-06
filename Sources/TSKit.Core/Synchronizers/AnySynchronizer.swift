// - Since: 01/05/2022
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

/// An object that synchronizes access to a critical section in a multithreaded environment.
public protocol AnySynchronizer: AnyObject {

    /// Provides synchronized **read-only** access within `block` in a multithreaded environment.
    ///
    /// Use `read` when you need to perform **read-only** operations within a criticial `block`.
    /// - Important: Attempting to *write* any changes might break synchronization,
    ///              as implementations of `AnySynchronizer` do not guarantee this behavior.
    /// - Important: *Read* operations do not have exclusive access (unlike *write* operations),
    ///              meaning that multiple `read`s might be performed at the same time.
    /// - Parameter block: Closure to be excecuted synchronously.
    func read<Result>(_ block: () throws -> Result) rethrows -> Result

    /// Provides synchronized **read-write** access within `block` in a multithreaded environment.
    ///
    /// Use `syncWrite` when you need to synchronously perform *write* operations within a criticial `block` and receive immediate results.
    /// - Important: *Write* operations have exclusive access,
    ///              meaning that no other `write`s or `read`s will be performed at the same time.
    /// - Note: *Reading* within this `block` is also synchronized and is safe to use.
    /// - Parameter block: Closure to be excecuted synchronously.
    /// - Returns: Result forwarded from the `block` closure.
    @discardableResult
    func syncWrite<Result>(_ block: () throws -> Result) rethrows -> Result

    /// Provides synchronized **read-write** access within `block` in a multithreaded environment.
    ///
    /// Use `write` when you don't need to wait for completion of the *write* operations perofrmed within `block`.
    /// - Important: *Write* operations have exclusive access,
    ///              meaning that no other `write`s or `read`s will be performed at the same time.
    /// - Note: *Reading* within this `block` is also synchronized and is safe to use.
    /// - Parameter block: Closure to be excecuted.
    func write(_ block: @escaping () -> Void)
}
