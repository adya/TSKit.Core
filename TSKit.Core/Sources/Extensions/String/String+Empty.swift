// - Since: 10/02/2019
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

public extension String {

    /// - Returns: self if it is not empty, otherwise `nil`.
    var nonEmpty: String? {
        return self.isEmpty ? nil : self
    }
}
