/// - Since: 10/04/2019
/// - Authors: Arkadii Hlushchevskyi
/// - Copyright: © 2019. Arkadii Hlushchevskyi.
/// - Seealsos: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

import Foundation

public extension BidirectionalCollection {

    /// Finds indices of all elements matching given `predicate`.
    /// - Parameter predicate: Closure that evaluates whether or not the element's index
    ///                        should be included in the result.
    /// - Returns: An array of indices of eligible elements.
    func allIndices(where predicate: (Iterator.Element) -> Bool) -> [Self.Index] {
        return indices.filter { predicate(self[$0]) }
    }
}
