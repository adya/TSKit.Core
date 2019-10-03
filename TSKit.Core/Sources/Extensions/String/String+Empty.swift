/// - Since: 10/02/2019
/// - Authors: Arkadii Hlushchevskyi
/// - Copyright: © 2019. Arkadii Hlushchevskyi.
/// - Seealsos: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

public extension String {

    /// - Returns: self if it is not empty, otherwise `nil`.
    var nonEmpty: String? {
        return self.isEmpty ? nil : self
    }
}
