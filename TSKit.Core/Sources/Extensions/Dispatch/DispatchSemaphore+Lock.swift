// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2019. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

import Dispatch

public extension DispatchSemaphore {

    /// Performs provided `block` within `signal` call
    /// resulting in a locked execution when semaphore value is `1`.
    /// - Parameter block: A closure to be executed within lock.
    /// - Returns: Result forwarded from the `block`.
    func inLock<Result>(_ block: () throws -> Result) rethrows -> Result {
        defer { self.signal() }
        self.wait()
        return try block()
    }
}
