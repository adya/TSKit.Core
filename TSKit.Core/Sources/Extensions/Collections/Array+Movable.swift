/// A collection extension that adds `move` method.

public extension Collection {
    
    /// Moves element at given `index` to new position at `newIndex`.
    /// - Parameter index: An index of the element to be moved.
    /// - Parameter newIndex: An index of the position in the array where element should be placed.
    mutating func move(from index: Int, to newIndex: Int) {
        guard index != newIndex else { return }
        let item = remove(at: index)
        insert(item, at: newIndex > count ? count : newIndex)
    }
}
