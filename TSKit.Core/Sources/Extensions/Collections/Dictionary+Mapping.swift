/// - Since: 01/20/2018
/// - Author: Arkadii Hlushchevskyi
/// - Copyright: © 2019. Arkadii Hlushchevskyi.
/// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

public extension Sequence {
    
    /// Maps `Sequence` to a `Dictionary` using `key` and `value` closures to build resulting `dictionary`.
    /// - Parameter key: A closure that provides a property of `Sequence`'s element to be used as a dictioanry key.
    /// - Parameter value: A closure that provides a property of `Sequence`'s element to be used as a dictioanry value.
    /// - Note: `key` must be unique in order to avoid collisions.
    /// - Returns: `Dictionary` containing key-value pairs.
    public func map<KeyType, ValueType>(key: (Iterator.Element) throws -> KeyType,
                                        value: (Iterator.Element) throws -> ValueType) -> [KeyType : ValueType] where KeyType : Hashable {
        let results: [KeyType : ValueType] = self.reduce([:]) {
            guard let key = try? key($1),
                let value = try? value($1) else {
                    return $0
            }
            var dic = $0
            dic[key] = value
            return dic
        }
        return results
    }
}

public extension Dictionary {
    
    /// Creates a new `Dictionary` by transforming each existing key-value pair using `transform` closure.
    /// - Parameter transform: Closure which applies transformation to key-value pairs.
    ///                        `transform` closure returns a transformed `(key, value)` tuple.
    ///                        In case of either `key`, `value` or tuple is `nil` transformation fails
    ///                        and current key-value pair will be skipped.
    /// - Returns: A new `dictionary` containing successfully transformed key-value pairs.
    public func flatMap<NewKeyType, NewValueType>(_ transform: (Iterator.Element) throws -> (NewKeyType?, NewValueType?)?) rethrows -> [NewKeyType : NewValueType] {
        var dict = [NewKeyType : NewValueType]()
        for pair in self {
            if let transformed = try transform(pair),
                let key = transformed.0,
                let value = transformed.1 {
                dict[key] = value
            }
        }
        return dict
    }
}


/// Appends all keys and values from `right` dictionary to `left`.
public func +=<K, V>(left: inout [K : V], right: [K : V]) {
    right.forEach { (k, v) in
        left[k] = v
    }
}

/// Creates a new dictionary containing all keys and values from both `left` and `right` dictionaries.
/// - Note: `left` decitionary has higher priority than `right` when resolving conflicting keys. This means that whenever both dictionaries will have the same key value from the `left` one will appear in resulting dictioanry.
public func +<K, V>(left: [K : V], right: [K : V]) -> [K : V] {
    var dic = right
    dic += left
    return dic
}

