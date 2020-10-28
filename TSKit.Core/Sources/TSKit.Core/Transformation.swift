// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

/// Performs `transformation` on specified `object` using `inout` closure.
/// - Parameter object: An object to which `transformation` will be applied.
/// - Parameter transformation: `inout` closure that performs transformation of the `object`.
/// - Attention: When passing reference type objects to this method
///             it will apply transformation to and will return the same object.
/// - Returns: Mutated object after transformations.
public func transform<ObjectType>(_ object: ObjectType,
                                  _ transformation: (inout ObjectType) -> Void) -> ObjectType {
    var object = object
    transformation(&object)
    return object
}

public extension Set {

    /// Performs `transformation` on elements of the collection using `inout` closure.
    /// - Parameter transformation: `inout` closure that performs transformation of each element.
    mutating func transform(_ transformation: (inout Element) -> Void) {
        self = transformed(transformation)
    }

    /// Performs `transformation` on elements of the collection using `inout` closure.
    /// - Parameter transformation: `inout` closure that performs transformation of each element.
    func transformed(_ transformation: (inout Element) -> Void) -> Self {
        Set(map {
            var item = $0
            transformation(&item)
            return item
        })
    }
}

public extension Array {

    /// Performs `transformation` on elements of the collection using `inout` closure.
    /// - Parameter transformation: `inout` closure that performs transformation of each element.
    mutating func transform(_ transformation: (inout Element) -> Void) {
        self = transformed(transformation)
    }

    func transformed(_ transformation: (inout Element) -> Void) -> Self {
        map {
            var item = $0
            transformation(&item)
            return item
        }
    }
}
