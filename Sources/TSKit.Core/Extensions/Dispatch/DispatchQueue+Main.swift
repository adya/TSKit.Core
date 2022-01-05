// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

import Dispatch
import Foundation

public extension DispatchQueue {
    
    func syncIfNeeded<Result>(_ execute: () -> Result) -> Result {
        if self == DispatchQueue.main && Thread.isMainThread {
            return execute()
        } else {
            return self.sync(execute: execute)
        }
    }
}
