// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

import Foundation

public extension Data {
    
    /// Size of the `Data` represented by `DataSize` object.
    var size: DataSize<Int> {
        return DataSize(bytes: count)
    }
}
