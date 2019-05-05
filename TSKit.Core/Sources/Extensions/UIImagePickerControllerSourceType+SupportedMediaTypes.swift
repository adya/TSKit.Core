/// - Since: 01/20/2018
/// - Author: Arkadii Hlushchevskyi
/// - Copyright: © 2019. Arkadii Hlushchevskyi.
/// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

import UIKit

extension UIImagePickerControllerSourceType {

    /// Checks whether `UIImagePickerController` supports given `mediaType`.
    /// - Parameter mediaType: Media type key. (`kUTType*` from `UTCoreTypes`).
    /// - Returns: `true` is `mediaType` is supported by `self`.
    func isSupports(mediaType: String) -> Bool {
        return UIImagePickerController.availableMediaTypes(for: self)?.contains(mediaType) ?? false
    }
}
