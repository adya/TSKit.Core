public extension BidirectionalCollection {
    
    /// Gets the last element matching specified `predicate`. Works the same way as `first(where:)`, but reversed.
    /// - Returns: Last element matching `predicate`.
    func last(where predicate: (Self.Iterator.Element) throws -> Bool) rethrows -> Self.Iterator.Element? {
        for index in self.indices.reversed() {
            let element = self[index]
            if try predicate(element) {
                return element
            }
        }
        return nil
    }
}
