// - Since: 01/05/2022
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

/// Wrapper that ensures synchronous access to a wrapped property.
@propertyWrapper
public class Synchronized<Value> {

    private let synchronizer: AnySynchronizer

    private var value: Value

    public var wrappedValue: Value {
        get { synchronizer.read { value } }
        set { synchronizer.write { self.value = newValue } }
    }

    public init(wrappedValue: Value, synchronizer: AnySynchronizer) {
        self.value = wrappedValue
        self.synchronizer = synchronizer
    }
}
