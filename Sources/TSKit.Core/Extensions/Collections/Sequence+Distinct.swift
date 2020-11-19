// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

public extension Sequence where Iterator.Element: Hashable {
    
    /// Filters duplicated `Hashable` elements of `Sequence`.
    /// - Returns: An array containing only distinct elements of the `Sequence`.
    var distinct: [Iterator.Element] {
        return Array(Set(self))
    }
}

public extension Sequence where Iterator.Element: Equatable {
    
    /// Filters duplicated `Equatable` elements of `Sequence`.
    /// - Returns: An array containing only distinct elements of the `Sequence`.
    var distinct: [Iterator.Element] {
        return reduce([]) { uniqueElements, element in
            uniqueElements.contains(element)
                ? uniqueElements
                : uniqueElements + [element]
        }
    }
}

public extension Sequence {
    
    /// Filters duplicated elements of the `Sequence` using element's property provided in `key`
    /// closure.
    /// - Note: Key property must conform to `Equatable` protocol.
    /// - Parameter key: A closure providing a key property of the element to compare.
    /// - Returns: An array containing only distinct elements of the `Sequence`.
    func distinct<T>(by key: (Self.Iterator.Element) -> T?) -> [Iterator.Element] where T : Equatable {
        return reduce(([], [])) { (unique: ([T], [Iterator.Element]), element: Iterator.Element) in
            guard let key = key(element) else {
                return unique
            }
            return unique.0.contains(key)
                ? unique
                : (unique.0 + [key], unique.1 + [element])
            }.1
    }
}
