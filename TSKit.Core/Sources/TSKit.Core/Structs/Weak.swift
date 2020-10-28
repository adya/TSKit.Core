// - Since: 09/09/2020
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

import Foundation

/// A wrapper object that holds weak reference to given `object`.
/// This wrapper is useful when certain objects in a collection need to be captured without producing retain cycle.
public class Weak<ObjectType> where ObjectType: AnyObject {

    public private(set) weak var object: ObjectType?
    
    public init(object: ObjectType) {
        self.object = object
    }
}
