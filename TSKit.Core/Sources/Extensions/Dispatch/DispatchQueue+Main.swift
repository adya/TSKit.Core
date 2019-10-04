/// - Since: 01/20/2018
/// - Authors: Arkadii Hlushchevskyi
/// - Copyright: © 2018. Arkadii Hlushchevskyi.
/// - Seealsos: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

import Dispatch

public extension DispatchQueue {
    
    func syncIfNeeded<Result>(_ execute: () -> Result) -> Result {
        if self == DispatchQueue.main && Thread.isMainThread {
            return execute()
        } else {
            return self.sync(execute: execute)
        }
    }
}
