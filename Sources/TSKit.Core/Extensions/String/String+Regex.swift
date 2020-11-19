// - Date: 10/31/2016
// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

// Date:
import Foundation

public extension String {
    
    /// A single matching group containing matched string and all groups captured from that match.
    typealias MatchingGroup = (match: String, groups: [(match: String, range: Range<String.Index>)])
    
    /// Extracts groups of substrings matching specified regular expression string `regex`.
    /// Each group contains matched string and an array of captured `regex` groups within that matched string.
    /// - Returns: Groups of substrings matched regex pattern.
    func groups(matchingRegex regex: String) throws -> [MatchingGroup] {
        let regex = try NSRegularExpression(pattern: regex, options: [])
        let nsString = self as NSString
        let results = regex.matches(in: self, range: NSRange(location: 0, length: nsString.length))
        return results.map { result in
            let match = nsString.substring(with: result.range(at: 0))
            let groups: [(String, Range<String.Index>)] = (1..<result.numberOfRanges).compactMap {
                let nsrange = result.range(at: $0)
                guard nsrange.location != NSNotFound,
                      let range = Range(nsrange, in: self) else {
                    return nil
                }
                return (String(self[range]), range)
            }
            return (match: match, groups: groups)
        }
    }
}

infix operator =~

/** Validates string with given regex pattern
 - Note: Requires exact match of the whole string. No submatches are allowed.
 Thus:
 ```
 "example" =~ ".{3}" // false
 "example" =~ ".{7}" // true
 ```
 - Parameter input: String to be validated.
 - Parameter pattern: Regex pattern to be matched.
 - Returns: Bool value indicating whether input matches the pattern.
 */
public func =~ (input: String, pattern: String) -> Bool {
    return input.range(of: pattern, options: .regularExpression) == input.startIndex..<input.endIndex
}
