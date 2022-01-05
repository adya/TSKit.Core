// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

public extension Set {
    
    /// Returns a pair of sets containing the elements of the set that satisfy the given predicate.
    /// Splits the elements of the set into two sets with elements that satisfy the given predicate and not.
    /// - Parameter isIncluded: A closure that takes an element of the set as its argument
    ///                         and returns a Boolean value indicating whether the element
    ///                         should be included in the first returned set or second.
    /// - Returns: A pair of sets where first set contains elements allowed by `isIncluded` and second set contains those elements which are not allowed.
    func filtered(_ isIncluded: (Element) throws -> Bool) rethrows -> (Set<Element>, Set<Element>) {
        return try reduce(([], [])) { result, element in
            return try isIncluded(element)
                ? (result.0.union(Set([element])), result.1)
                : (result.0, result.1.union(Set([element])))
        }
    }
}
