// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

/// A set of extension methods that add immutable counterparts of mutating methods `append`, `remove`, `move`.
public extension Array {
    
    /// Creates new array with an element at given `index` moved to new position at `newIndex`.
    /// - Parameter index: An index of the element to be moved.
    /// - Parameter newIndex: An index of the position in the array where element should be placed.
    /// - Returns: An array with the element moved to new position.
    func moving(from index: Index, to newIndex: Index) -> Array {
        return TSKit_Core.transform(self) { $0.move(from: index, to: newIndex) }
    }
    
    /// Creates new array with an element appended.
    /// - Parameter index: An element to be appended.
    /// - Returns: An array with appended element.
    func appending(_ element: Element) -> [Element] {
        return TSKit_Core.transform(self) { $0.append(element) }
    }
    
    /// Creates new array with an element at given `index` removed.
    /// - Parameter index: An index of the element to be removed.
    /// - Returns: An array with removed element.
    func removing(at index: Index) -> [Element] {
        return TSKit_Core.transform(self) { $0.remove(at: index) }
    }
}

public extension Array where Element: Equatable {
    
    /// Creates new array with specified `element` removed.
    /// The `element` must conform to `Equatable` protocol.
    /// - Parameter element: An element to be removed.
    /// - Returns: An array with removed element.
    func removing(_ element: Element) -> [Element] {
        return TSKit_Core.transform(self) { $0[element] = nil }
    }
    
}

public extension Array {

    /// Removes first element that satisfies predicate from array.
    /// - Complexity: `O(n)`, where `n` is the length of the array.
    /// - Parameter predicate: A closure that takes an element of the array as its argument and
    ///                        returns a `Boolean` value indicating whether the element satisfies predicate.
    /// - Returns: Removed element if any, otherwise `nil`.
    @discardableResult
    mutating func removeFirst(where predicate: (Iterator.Element) -> Bool) -> Element? {
        guard let index = firstIndex(where: predicate) else { return nil }
        return remove(at: index)
    }
}
