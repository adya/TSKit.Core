/// - Since: 01/20/2018
/// - Author: Arkadii Hlushchevskyi
/// - Copyright: © 2019. Arkadii Hlushchevskyi.
/// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

import Dispatch

extension DispatchSemaphore {

    func inLock<Result>(_ block: () throws -> Result) rethrows -> Result {
        defer { self.signal() }
        self.wait()
        return try block()
    }
}
