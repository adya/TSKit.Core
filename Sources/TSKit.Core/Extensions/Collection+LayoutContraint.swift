// - Since: 07/04/2021
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2021. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Networking.Alamofire/blob/master/LICENSE.md
#if os(iOS)
import UIKit

public extension Collection where Element == NSLayoutConstraint {
    
    /// Activates each constraint contained in self.
    ///
    /// This convenience method provides an easy way to activate a set of constraints with one call.
    /// The effect of this method is the same as setting the isActive property of each constraint to true.
    /// Typically, using this method is more efficient than activating each constraint individually.
    /// - Note: This method is a shorthand for `NSLayoutConstraint.activate(_:)`.
    func activate() {
        NSLayoutConstraint.activate(Array(self))
    }
    
    /// Deactivates each constraint contained in self.
    ///
    /// This is a convenience method that provides an easy way to deactivate a set of constraints with one call.
    /// The effect of this method is the same as setting the isActive property of each constraint to false.
    /// Typically, using this method is more efficient than deactivating each constraint individually.
    /// - Note: This method is a shorthand for `NSLayoutConstraint.deactivate(_:)`.
    func deactivate() {
        NSLayoutConstraint.deactivate(Array(self))
    }
}
#endif
