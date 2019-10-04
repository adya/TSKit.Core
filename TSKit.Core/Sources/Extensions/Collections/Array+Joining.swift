/// - Since: 01/20/2018
/// - Authors: Arkadii Hlushchevskyi
/// - Copyright: © 2018. Arkadii Hlushchevskyi.
/// - Seealsos: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

public extension Array {
    
    func joined(with separator: Element) -> [Element] {
        guard count > 1 else { return self }
        let joined: [[Element]] = enumerated().map { (index, element) in
            guard index != count - 1 else {
                return [element]
            }
            return [element, separator]
        }
        return joined.flatMap { $0 }
    }
}

public extension Array {
    
    /// Creates new array with subarrays splitted by `chunkSize`.
    /// - Parameter chunkSize: Size of the chunk.
    /// - Returns: An array of arrays splitted by `chunkSize`.
    func split(by chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: chunkSize).map {
            Array(self[$0..<Swift.min($0 + chunkSize, self.count)])
        }
    }
}

