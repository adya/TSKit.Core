// - Since: 11/25/2021
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2021. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

import TSKit_Core_ObjC

let handler = ExceptionThrower()

/// Safely executes given `block` that runs *Objective-C* bridged code that might generate `NSException`.
///
/// When the `block` generates a runtime exception it will be rethrown as an `Error` using common *Swift*'s throwing mechanism.
/// - Note: If `block` doesn't have any *Objectve-C* bridged code, then this method won't do anything.
/// - Parameter block: Closure that runs *Objective-C* bridged code that might generate NSException.
public func tryWithException(_ block: @escaping () -> Void) throws {
    try handler.catchException(in: block)
}
