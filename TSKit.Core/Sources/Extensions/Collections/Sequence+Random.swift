/// - Since: 01/20/2018
/// - Author: Arkadii Hlushchevskyi
/// - Copyright: © 2019. Arkadii Hlushchevskyi.
/// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

/// Extensions that add randomization methods
public extension Collection {
    
    /// Gets random value from the range.
    public var random: Self.Element {
        if let startIndex = self.startIndex as? Int {
            let start = UInt32(startIndex)
            let end = UInt32(self.endIndex as! Int)
            return self[Int(arc4random_uniform(end - start) + start) as! Self.Index]
        }
        var generator = self.makeIterator()
        var count = arc4random_uniform(UInt32(self.count))
        while count > 0 {
            let _ = generator.next()
            count = count - 1
        }
        return generator.next()!
    }
}

public extension Array {
    
    
    // TODO: Make two methods for mutating and immutable variants.
    
    /// Creates a new array by randomly shuffling elements of current one.
    /// - Returns: An array containing all original elements in shuffled order.
    public var shuffled: Array {
        var shuffled = self
        indices.dropLast().forEach { a in
            guard case let b = Int(arc4random_uniform(UInt32(count - a))) + a, b != a else {
                return
            }
            shuffled.move(from: a, to: b)
        }
        return shuffled
    }
    
    /// Creates a new array containing `n` elements from the original array picked up randomly.
    /// - Parameter count: Number of elements to be returned.
    /// - Returns: An array containing `n` elements from current one.
    public func random(_ count: Int) -> Array {
        return Array(shuffled.prefix(count))
    }
}

// TODO: Fix this
extension Range {
    
    /// Gets random value from the interval.
    public var random: Bound {
        let range = (self.upperBound as! Float) - (self.lowerBound as! Float)
        let randomValue = (Float(arc4random_uniform(UInt32.max)) / Float(UInt32.max)) * range + (
            self.lowerBound as! Float)
        return randomValue as! Bound
    }
}
