public extension String {
    
    /// Creates new string by removing any html tags from `self`.
    /// - Returns: String without html tags.
    func removingHtmlTags() -> String {
        return replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
