// - Since: 10/02/2019
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md
import Foundation

@available(OSX 10.11, *)
public extension URL {
    
    /// Creates an `url` that is resolved relatively to specified `root`.
    ///
    /// The following example shows the effect of applying this method to an url.
    ///
    ///     let root = URL(fileURLWithPath: "my/root/")
    ///     let absoluteFile = URL(fileURLWithPath: "my/root/somewhere/deep/down/file")
    ///     let relativeFile = absoluteFile.relative(to: root)
    ///     print(relativeFile)
    ///     // Prints "somewhere/deep/down/file" and baseUrl = "my/root"
    func relative(to root: URL) -> URL {
        return URL(fileURLWithPath: path.replacingOccurrences(of: root.path, with: "").dropFirst() ==> String.init,
                   relativeTo: root)
    }
}
