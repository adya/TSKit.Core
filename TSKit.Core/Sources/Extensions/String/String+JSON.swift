import Foundation
///  Created by AdYa on 9/20/16.


public extension String {
    
    /// Dictionary representing `JSON` object contained in `String` otherwise `nil`.
    public var dictionary : [String : Any]? {
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
