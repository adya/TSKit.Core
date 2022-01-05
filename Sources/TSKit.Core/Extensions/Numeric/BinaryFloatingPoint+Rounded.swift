// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

import Foundation

public typealias DecimalPlaces = Int

public extension BinaryFloatingPoint {

    /// Rounds the number to specified number of decimal places.
    @available(swift, deprecated: 5, message: "Use `rounded(rule:)`")
    func rounded(to places: DecimalPlaces) -> Self {
        let floatingPlaces = Self.init(pow(10.0, Double(max(0, places))))
        return floor(floatingPlaces * self) / floatingPlaces
    }
    
    /// Rounds the number to specified number of decimal places.
    mutating func round(to places: DecimalPlaces) {
        let floatingPlaces = Self.init(pow(10.0, Double(max(0, places))))
        self = floor(self * floatingPlaces) / floatingPlaces
    }
}
