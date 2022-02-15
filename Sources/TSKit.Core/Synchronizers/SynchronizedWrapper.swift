// - Since: 01/05/2022
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

/// Wrapper that ensures synchronous access to a wrapped property.
@propertyWrapper
public class Synchronized<Value> {

    fileprivate let synchronizer: AnySynchronizer
    
    fileprivate var value: Value
    
    public var projectedValue: Synchronized { self }

    public var wrappedValue: Value {
        get { synchronizer.read { value } }
        set { synchronizer.syncWrite { self.value = newValue } }
    }
    
    /// Accesses wrapped value and replaces it with the new value within a single synchronized block.
    ///
    /// This method serves an optimization purpose for cases when one need to read current value and replace it with a new value afterwards.
    /// For example the following code will produce two synchronized blocks.
    /// ```
    /// @Synchronized
    /// var property: Int = 5
    ///
    /// func doSomething() {
    ///     let current = property
    ///     property = 0
    /// }
    /// ```
    /// But using `replace(with:)` the same behavior can be achieved using only one synchronized block:
    /// ```
    /// func doSomething() {
    ///     let current = $property.replace(with: 0)
    ///     print(current)
    ///     // Prints "5"
    /// }
    /// ```
    /// - Parameter newValue: The value that will be set to the wrapped value.
    /// - Returns: The value that was stored before the replace.
    public func replace(with newValue: Value) -> Value {
        synchronizer.syncWrite {
            let oldValue = value
            value = newValue
            return oldValue
        }
    }
    
    /// Accesses wrapped value and applies given transformation to it afterwards within a single synchronized block.
    ///
    /// This method serves an optimization purpose for cases when one need to read current value and transform it afterwards.
    /// For example the following code will produce two synchronized blocks.
    /// ```
    /// @Synchronized
    /// var property: [Int] = [1, 3, 5]
    ///
    /// func doSomething() {
    ///     let current = property
    ///     property.reverse()
    /// }
    /// ```
    /// But using `transform(_:)` the same behavior can be achieved using only one synchronized block:
    /// ```
    /// func doSomething() {
    ///     let current = $property.transform { $0.reverse() }
    ///     print(current)
    ///     // Prints "[1, 3, 5]"
    /// }
    /// ```
    /// - Parameter transformation: A closure that will apply transformations to the wrapped value.
    /// - Returns: The value that was stored before the transform.
    public func transform(_ transformation: (_ value: inout Value) -> Void) -> Value {
        synchronizer.syncWrite {
            let oldValue = self.value
            transformation(&self.value)
            return oldValue
        }
    }

    public init(wrappedValue: Value, synchronizer: AnySynchronizer) {
        self.value = wrappedValue
        self.synchronizer = synchronizer
    }
}

/// Wrapper that ensures synchronous access to a wrapped property.
///
/// This wrapper is similar to regular `Synchronized`, but it uses default asynchrounous `write` access block of the underlying `synchronizer`.
@propertyWrapper
public class AsyncSynchronized<Value>: Synchronized<Value> {
    
    public override var wrappedValue: Value {
        get { super.wrappedValue }
        set { synchronizer.write { self.value = newValue } }
    }
}
