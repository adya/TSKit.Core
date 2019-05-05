/// - Since: 01/20/2018
/// - Author: Arkadii Hlushchevskyi
/// - Copyright: © 2019. Arkadii Hlushchevskyi.
/// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

import Foundation

extension BinaryFloatingPoint {

    /// Rounds the number to specified number of decimal places.
    func rounded(toDigits digits: Int) -> Self {
        let floatingPlaces = Self.init(pow(10.0, Double(digits)))
        return floor(floatingPlaces * self) / floatingPlaces
    }
}
