// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

/// A collection extension that adds `move` method.
public extension Array {
    
    /// Moves element at given `index` to new position at `newIndex`.
    /// - Parameter index: An index of the element to be moved.
    /// - Parameter newIndex: An index of the position in the array where element should be placed.
    mutating func move(from index: Index, to newIndex: Index) {
        guard index != newIndex else { return }
        let item = remove(at: index)
        insert(item, at: newIndex > count ? count : newIndex)
    }
}
