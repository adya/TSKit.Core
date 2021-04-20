// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

public extension Sequence where Iterator.Element: Hashable {
    
    /// Filters duplicated `Hashable` elements of the `Sequence`.
    ///
    /// Elements are determined as distinct by forming a `Set`.
    /// - Attention: Order of the sequence is not preserved. When order is important use either `distinctFirst` or `distinctLast`.
    /// - Returns: An array containing only distinct elements of the `Sequence`.
    var distinct: [Iterator.Element] {
        Array(Set(self))
    }
}

public extension Sequence where Iterator.Element: Equatable {
    
    /// Filters duplicated `Equatable` elements of the `Sequence`.
    ///
    /// Elements are determined as distinct by comparing them using `Equatable` protocol.
    /// When duplicates are found the first occurrence is considered to be unique and will be included in the result,
    /// all subsequent duplicates will be ignored.
    /// - Returns: An array containing only distinct elements of the `Sequence`.
    @available(*, renamed: "distinctFirst", message: "Property has been renamed as part of extended API for filtering distinct elements")
    var distinct: [Iterator.Element] {
        distinctFirst
    }
    
    /// Filters duplicated `Equatable` elements of the `Sequence`.
    ///
    /// Elements are determined as distinct by comparing them using `Equatable` protocol.
    /// When duplicates are found the first occurrence is considered to be unique and will be included in the result,
    /// all subsequent duplicates will be ignored.
    /// - Returns: An array containing only distinct elements of the `Sequence`.
    /// - Seealso: `distinctLast`
    /// - Complexity: `O(n*m)`, where `n` is the length of the sequence and `m` is number of unique elements in the sequence.
    var distinctFirst: [Iterator.Element] {
        reduce([]) { uniqueElements, element in
            uniqueElements.contains(element)
                ? uniqueElements
                : uniqueElements + [element]
        }
    }
    
    /// Filters duplicated `Equatable` elements of the `Sequence`.
    ///
    /// Elements are determined as distinct by comparing them using `Equatable` protocol.
    /// When duplicates are found the last occurrence is considered to be unique and will be included in the result,
    /// all previous duplicates will be ignored.
    /// - Returns: An array containing only distinct elements of the `Sequence`.
    /// - Seealso: `distinctFirst`
    /// - Complexity: `O(n*m)`, where `n` is the length of the sequence and `m` is number of unique elements in the sequence.
    var distinctLast: [Iterator.Element] {
        reversed().reduce([]) { uniqueElements, element in
            uniqueElements.contains(element)
                ? uniqueElements
                : uniqueElements + [element]
        }.reversed()
    }
}

public extension Sequence {
    
    /// Filters duplicated elements of the `Sequence` using custom `Equatable` value provided for each element in `key` closure.
    ///
    /// Elements are determined as distinct by comparing result of the `key` closure for each element.
    /// When duplicates are found the first occurrence is considered to be unique and will be included in the result,
    /// all subsequent duplicates will be ignored.
    /// - Parameter key: A closure providing an `Equatable` value used as a key to compare elements.
    /// - Returns: An array containing only distinct elements of the `Sequence`.
    /// - Seealso: `distinctLast`
    /// - Complexity: `O(n*m)`, where `n` is the length of the sequence and `m` is number of unique elements in the sequence.
    @available(*, renamed: "distinctFirst", message: "Method has been renamed as part of extended API for filtering distinct elements")
    func distinct<T>(by key: (Self.Iterator.Element) -> T?) -> [Iterator.Element] where T : Equatable {
        distinctFirst(by: key)
    }
    
    /// Filters duplicated elements of the `Sequence` using custom `Equatable` value provided for each element in `key` closure.
    ///
    /// Elements are determined as distinct by comparing result of the `key` closure for each element.
    /// When duplicates are found the first occurrence is considered to be unique and will be included in the result,
    /// all consequental duplicates will be ignored.
    /// - Parameter key: A closure providing an `Equatable` value used as a key to compare elements.
    /// - Returns: An array containing only distinct elements of the `Sequence`.
    /// - Seealso: `distinctLast`
    /// - Complexity: `O(n*m)`, where `n` is the length of the sequence and `m` is number of unique elements in the sequence.
    func distinctFirst<T>(by key: (Self.Iterator.Element) -> T?) -> [Iterator.Element] where T : Equatable {
        reduce(([], [])) { (unique: ([T], [Iterator.Element]), element: Iterator.Element) in
            guard let key = key(element) else {
                return unique
            }
            return unique.0.contains(key)
                ? unique
                : (unique.0 + [key], unique.1 + [element])
        }.1
    }
    
    /// Filters duplicated elements of the `Sequence` using custom `Equatable` value provided for each element in `key` closure.
    ///
    /// Elements are determined as distinct by comparing result of the `key` closure for each element.
    /// When duplicates are found the last occurrence is considered to be unique and will be included in the result,
    /// all previous duplicates will be ignored.
    /// - Parameter key: A closure providing an `Equatable` value used as a key to compare elements.
    /// - Returns: An array containing only distinct elements of the `Sequence`.
    /// - Seealso: `distinctLast`
    /// - Complexity: `O(n*m)`, where `n` is the length of the sequence and `m` is number of unique elements in the sequence.
    func distinctLast<T>(by key: (Self.Iterator.Element) -> T?) -> [Iterator.Element] where T : Equatable {
        reversed().reduce(([], [])) { (unique: ([T], [Iterator.Element]), element: Iterator.Element) in
            guard let key = key(element) else {
                return unique
            }
            return unique.0.contains(key)
                ? unique
                : (unique.0 + [key], unique.1 + [element])
        }.1.reversed()
    }
}
