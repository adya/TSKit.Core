public extension Collection {
    
    /// Finds such index N that predicate is true for all elements up to
    /// but not including the index N, and is false for all elements
    /// starting with index N.
    /// Behavior is undefined if there is no such N.
    func orderedIndex(where predicate: (Iterator.Element) -> Bool) -> Index {
        return orderedIndex(where: predicate, in: startIndex..<endIndex)
    }
    
    func orderedIndex(where predicate: (Iterator.Element) -> Bool, in range: Range<Index>) -> Index {
        guard range.lowerBound != range.upperBound else { return range.lowerBound }
        let distance = self.distance(from: range.lowerBound, to: range.upperBound)
        let mid = index(range.lowerBound, offsetBy: distance / 2)
        let isMatching = predicate(self[mid])
        guard distance > 1 else { return isMatching ? range.upperBound : range.lowerBound }
        let myRange = isMatching
            ? mid..<range.upperBound
            : range.lowerBound..<mid
        return orderedIndex(where: predicate, in: myRange)
    }
}
