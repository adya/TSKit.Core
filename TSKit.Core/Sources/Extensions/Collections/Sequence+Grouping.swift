/// - Since: 01/20/2018
/// - Author: Arkadii Hlushchevskyi
/// - Copyright: © 2019. Arkadii Hlushchevskyi.
/// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

public extension Sequence {
    
    /// Groups any sequence by the key specified in the closure and creates a dictionary.
    /// - Note: `key` must conform to `Hashable` protocol.
    /// - Parameter key: A closure that provides a key property of `Sequence` elements to group by.
    /// - Returns: A dictionary with all elements grouped by specified `key`.
    func group<KeyType:Hashable>(by key: (Iterator.Element) -> KeyType?) -> [KeyType : [Iterator.Element]] {
        let results: [KeyType : Array<Iterator.Element>] = self.reduce([:]) {
            guard let key = key($1) else {
                return $0
            }
            var dic = $0
            if var array = dic[key] {
                array.append($1)
                dic[key] = array
            } else {
                dic[key] = [$1]
            }
            return dic
        }
        return results
    }
}
