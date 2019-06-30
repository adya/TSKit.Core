/// - Since: 01/20/2018
/// - Author: Arkadii Hlushchevskyi
/// - Copyright: © 2018. Arkadii Hlushchevskyi.
/// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

/// Performs `transformation` on specified `object` using `inout` closure.
/// - Parameter object: An object to which `transformation` will be applied.
/// - Parameter transformation: `inout` closure that performs transformation of the `object`.
/// - Attention: When passing reference type objects to this method
///             it will apply transformation to and will return the same object.
/// - Returns: Mutated object after transformations.
public func inoutTransform<ObjectType>(_ object: ObjectType,
                                       _ transformation: (inout ObjectType) -> Void) -> ObjectType {
    var object = object
    transformation(&object)
    return object
}
