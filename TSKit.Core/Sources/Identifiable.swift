// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2019. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

/// Defines a way to identify any object.
public protocol Identifiable {
    
    /// Identifier of a type.
    static var identifier: String {get}
    
    /// Identifier of the type of an instance.
    var identifier: String {get}
}

// MARK: - Defaults
public extension Identifiable {
    
    static var identifier: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
    
    var identifier: String {
        return type(of: self).identifier
    }
}

