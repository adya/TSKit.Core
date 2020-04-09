// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

/// An object that represents result of some work as either success with some data or failure with an error.
/// To utilize `Result` in cases when no meaningful result data expected `Result<Void>` can be used instead.
/// - Note: For convenience `Result<Void>` has `completed` property which represents `.success` of an empty result.

@available(swift, deprecated: 4, message: "Use `Swift.Result`")
public enum Result<ResultType> {

    /// Successful result.
    case success(ResultType)

    /// Unsuccessful result.
    case failure(Error)

}

// MARK: - Empty Result
public extension Result where ResultType == Void {

    var completed: Result {
        return .success(())
    }
}
