/// Defines a way to identify any object.
public protocol Identifiable {
    
    /// Identifier of the type.
    static var identifier: String {get}
    
    /// Identifier of `self`.
    var identifier: String {get}
}

// MARK: - Defaults
public extension Identifiable {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    var identifier: String {
        return type(of: self).identifier
    }
}
