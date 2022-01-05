// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

import Foundation

public extension String {
    
    func nsRange(from range: Range<String.Index>) -> NSRange? {
        guard let from = range.lowerBound.samePosition(in: utf16),
        let to = range.upperBound.samePosition(in: utf16) else {
            return nil
        }
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from),
                length: utf16.distance(from: from, to: to))
    }

    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
                let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
                let to16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location + nsRange.length, limitedBy: utf16.endIndex),
                let from = from16.samePosition(in: self),
                let to = to16.samePosition(in: self)
                else { return nil }
        return from ..< to
    }
}
