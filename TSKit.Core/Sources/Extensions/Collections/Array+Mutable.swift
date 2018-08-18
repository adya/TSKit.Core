/*
 * A set of extension methods that add immutable counterparts of mutating methods `append`, `remove`, `move`.
 */

public extension Collection {
    
    /// Creates new array with an element at given `index` moved to new position at `newIndex`.
    /// - Parameter index: An index of the element to be moved.
    /// - Parameter newIndex: An index of the position in the array where element should be placed.
    /// - Returns: An array with the element moved to new position.
    func moving(from index: Int, to newIndex: Int) -> Array {
        return modifying { $0.move(from: index, to: newIndex) }
    }
    
    /// Creates new array with an element appended.
    /// - Parameter index: An element to be appended.
    /// - Returns: An array with appended element.
    func appending(_ element: Element) -> [Element] {
        return modifying { $0.append(element) }
    }
    
    /// Creates new array with an element at given `index` removed.
    /// - Parameter index: An index of the element to be removed.
    /// - Returns: An array with removed element.
    func removing(at index: Index) -> [Element] {
        return modifying { $0.remove(at: index) }
    }
}

public extension Array where Element: Equatable {
    
    /// Creates new array with specified `element` removed.
    /// The `element` must conform to `Equatable` protocol.
    /// - Parameter element: An element to be removed.
    /// - Returns: An array with removed element.
    func removing(_ element: Element) -> [Element] {
        return modifying { $0[element] = nil }
    }
    
}

private extension Array {
    
    func modifying(_ editing: (_ copy: inout Array) -> Void) -> Array {
        var copy = self
        editing(&copy)
        return copy
    }
}
