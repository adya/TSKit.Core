import UIKit

extension UIImagePickerControllerSourceType {

    /// Checks whether `UIImagePickerController` supports given `mediaType`.
    /// - Parameter mediaType: Media type key. (`kUTType*` from `UTCoreTypes`).
    /// - Returns: `true` is `mediaType` is supported by `self`.
    func isSupports(mediaType: String) -> Bool {
        return UIImagePickerController.availableMediaTypes(for: self)?.contains(mediaType) ?? false
    }
}
