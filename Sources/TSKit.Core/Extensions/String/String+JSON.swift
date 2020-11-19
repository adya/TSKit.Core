// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

import Foundation

public extension String {
    
    /// Dictionary representing `JSON` object contained in `String` otherwise `nil`.
    var dictionary : [String : Any]? {
        if let data = self.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String : AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
}
