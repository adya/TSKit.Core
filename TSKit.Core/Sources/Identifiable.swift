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
        return String(describing: self)
    }
    
    var identifier: String {
        return type(of: self).identifier
    }
}
