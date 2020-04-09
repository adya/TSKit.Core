// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

public extension UInt {
    
    /// Initializes `UInt` value with `string` converting it to number in specified radix.
    init?(string: String, radix: UInt) {
        let digits = "0123456789abcdefghijklmnopqrstuvwxyz"
        var result = UInt(0)
        for digit in string.lowercased() {
            if let digitIndex = digits.firstIndex(of: digit) {
                let val = UInt(digits.distance(from: digits.startIndex, to: digitIndex))
                if val >= 0 && val < radix {
                    result = result * radix + val
                }
                else {
                    return nil
                }
            } else {
                return nil
            }
        }
        self = result
    }
}
