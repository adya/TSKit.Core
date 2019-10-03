/// - Since: 10/02/2019
/// - Authors: Arkadii Hlushchevskyi
/// - Copyright: © 2019. Arkadii Hlushchevskyi.
/// - Seealsos: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

public extension Collection {

    /// - Returns: self if it is not empty, otherwise `nil`.
    var nonEmpty: Self? {
        return self.isEmpty ? nil : self
    }
}
