// - Since: 01/06/2022
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

/// Reentrance detetor that always remains in non entered state, effectively disabling reetrance.
public class NonReentrantDetector: AnyConcurrentReentranceDetector {
    
    public let isEntered = false
    
    public init() {}
    
    public func enter() -> Bool { true }
    
    public func leave() {}
}
