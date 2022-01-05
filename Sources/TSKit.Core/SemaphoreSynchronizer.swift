// - Since: 01/05/2022
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md
import Dispatch

/// **Not** reentrant synchronizer that is based on a concurrent `DispatchQueue`.
public final class SemaphoreSynchronizer: AnySynchronizer {

    private let semaphore: DispatchSemaphore

    public init(value: UInt = 1) {
        semaphore = DispatchSemaphore(value: Int(value))
    }

    public func read<Result>(_ block: () throws -> Result) rethrows -> Result {
        return try semaphore.inLock(block)
    }

    @discardableResult
    public func syncWrite<Result>(_ block: () throws -> Result) rethrows -> Result {
        return try semaphore.inLock(block)
    }

    public func write(_ block: @escaping () -> Void) {
        semaphore.inLock(block)
    }
}
