// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

import UIKit

extension UIImagePickerController.SourceType {

    /// Checks whether `UIImagePickerController` supports given `mediaType`.
    /// - Parameter mediaType: Media type key. (`kUTType*` from `UTCoreTypes`).
    /// - Returns: `true` is `mediaType` is supported by `self`.
    func isSupporting(mediaType: String) -> Bool {
        return UIImagePickerController.availableMediaTypes(for: self)?.contains(mediaType) ?? false
    }
}
