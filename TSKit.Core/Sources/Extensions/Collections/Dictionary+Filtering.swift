// MARK: Dictionary filtering
public extension Dictionary {
    
    /// Creates a new `Dictionary` by filtering current one using `includeElement` closure.
    /// - Parameter includeElement: A closure used as predicate to filter elements.
    /// - Returns: New dictionary containing only filtered elements.
    public func filtered(includeElement: (Iterator.Element) throws -> Bool) rethrows -> [Key : Value] {
            var dict = [Key : Value]()
            let res: [Iterator.Element] = try self.filter(includeElement)
            res.forEach {
                dict[$0.0] = $0.1
            }
            return dict
    }
}
