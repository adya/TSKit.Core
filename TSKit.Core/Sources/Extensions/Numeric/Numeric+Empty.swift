/// - Since: 10/02/2019
/// - Authors: Arkadii Hlushchevskyi
/// - Copyright: © 2019. Arkadii Hlushchevskyi.
/// - Seealsos: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

public extension Numeric {

    /// - Returns: self if it does not equal zero, otherwise `nil`.
    var nonZero: Self? {
        return self == 0 ? nil : self
    }
}
