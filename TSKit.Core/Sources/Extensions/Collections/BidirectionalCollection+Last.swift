// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2019. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

public extension BidirectionalCollection {
    
    /// Gets the last element matching specified `predicate`. Works the same way as `first(where:)`, but reversed.
    /// - Returns: Last element matching `predicate`.
    func last(where predicate: (Element) throws -> Bool) rethrows -> Element? {
        for index in self.indices.reversed() {
            let element = self[index]
            if try predicate(element) {
                return element
            }
        }
        return nil
    }
    
    /// Returns the last element of the sequence that satisfies the given `predicate`.
    /// - Parameter predicate: A closure that takes an element of the sequence as its argument and returns a `Boolean` value indicating whether the element is a match.
    /// - Returns: The `last` element of the sequence that satisfies predicate, or `nil` if there is no element that satisfies `predicate`.
    func lastIndex(where predicate: (Element) throws -> Bool) rethrows -> Index? {
        return try reversed().firstIndex(where: predicate).flatMap { self.index(before: $0.base) }
    }
}

public extension BidirectionalCollection where Element: Equatable {
    
    /// Returns the last index where the specified value appears in the collection.
    /// After using `lastIndex(of:)` to find the last position of a particular element in a collection, you can use it to access the element by subscripting.
    /// - Parameter element: The element to find the last Index
    func lastIndex(of element: Element) -> Index? {
        return reversed().firstIndex(of: element).flatMap { self.index(before: $0.base) }
    }
}
