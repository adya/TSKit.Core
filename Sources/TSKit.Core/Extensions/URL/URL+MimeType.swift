import Foundation
#if !os(macOS)
import MobileCoreServices
#endif

public extension URL {
    
    /// Determines mime type of the file based on path extension.
    var mimeType: String? {
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, self.pathExtension as NSString, nil)?.takeRetainedValue(),
           let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
            return mimetype as String
        }
        return nil
    }
}
