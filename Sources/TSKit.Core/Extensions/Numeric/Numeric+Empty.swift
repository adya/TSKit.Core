// - Since: 10/02/2019
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

public extension Numeric {

    /// - Returns: self if it does not equal zero, otherwise `nil`.
    var nonZero: Self? {
        return self == 0 ? nil : self
    }
}
