
extension String {
    
    /// - Returns: Groups of substrings matched regex pattern.
    func substrings(matchingRegex regex: String) -> [[String]] {
        guard let regex = try? NSRegularExpression(pattern: regex, options: []) else { return [] }
        let nsString = self as NSString
        let results  = regex.matches(in: self, range: NSRange(location: 0, length: nsString.length))
        return results.map { result in
            (0..<result.numberOfRanges).map { result.range(at: $0).location != NSNotFound
                ? nsString.substring(with: result.range(at: $0))
                : ""
            }
        }
    }
}

// Date: 10/31/2016
import Foundation

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

