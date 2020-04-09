// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

public extension Array where Element: Equatable {
    
    /**
     Allows to access element in the array by it's value.
     
     When using `get` you can get an array value before the update.
     ```
      // Assume array contains Equatable objects with unique ids and `property1` set to "value".

      let obj1 = array[0] // obj1.property1 = "value"
      obj1.property1 = "newValue"
      let oldObj1 = array[obj1] // Here oldObj1 will be found by id, thus will contain oldValue.
      print(oldObj1.property1) // Prints "value"
     ```

     When using `set` you can replace an old element with new one at the same position.

     ```
      array[oldObj1] = oldObj1 // or array[obj1]. Doesn't matter as long as obj1 has the same id.
      print(array[0].property1) // Prints "newValue".
     ```
     - Parameter element: An element to be found.
     - Note: `Element` must conform to `Equatable`.
     - Note: Useful when you need to update value in the array and don't know its index.
     - Returns: An element contained in the array.
     
     - Complexity: `O(n)`, where `n` is the length of the collection.
     */
    subscript(element: Element) -> Element? {
        get {
            if let index = self.firstIndex(of: element) {
                return self[index]
            } else {
                return nil
            }
        }
        set {
            if let index = self.firstIndex(of: element) {
                if let newValue = newValue {
                    self[index] = newValue
                } else {
                    self.remove(at: index)
                }
            }
        }
    }
}
