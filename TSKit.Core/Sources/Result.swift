/// An object that represents result of some work as either success with some data or failure with an error.
/// To utilize `Result` in cases when no meaningful result data expected `Result<Void>` can be used instead.
/// - Note: For convenience `Result<Void>` has `completed` property which represents `.success` of an empty result.
enum Result<ResultType> {

    /// Successful result.
    case success(ResultType)

    /// Unsuccessful result.
    case failure(Error)

}

// MARK: - Empty Result
extension Result where ResultType == Void {

    var completed: Result {
        return .success(())
    }
}
