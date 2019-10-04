/// - Since: 01/20/2018
/// - Authors: Arkadii Hlushchevskyi
/// - Copyright: © 2018. Arkadii Hlushchevskyi.
/// - Seealsos: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

import Foundation
import CoreImage

/// An object that provides metadata of the image file.
public class ImageMetaReader {

    
    public init() {}
    
    /// Gets dimensions of the image at specified `url`.
    /// - Parameter url: An url of the image.
    /// - Returns: A `CGSize` object representing dimensions of the image
    ///            or `nil` if file at url is not an image or doesn't exist.
    public func size(ofImageAt url: URL) -> CGSize? {
        guard let source = CGImageSourceCreateWithURL(url as CFURL, nil) else { return nil }
        let options = [kCGImageSourceShouldCache : false] as CFDictionary

        guard let properties = CGImageSourceCopyPropertiesAtIndex(source, 0, options) as? [CFString : Any] else {
            return nil
        }

        guard let width = (properties[kCGImagePropertyPixelWidth] as? NSNumber)?.doubleValue,
              let height = (properties[kCGImagePropertyPixelHeight] as? NSNumber)?.doubleValue else {
            return nil
        }

        return CGSize(width: width, height: height)
    }

}
