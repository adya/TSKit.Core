import Foundation

public extension Data {
    
    /// Size of the `Data` represented by `DataSize` object.
    var size: DataSize<Int> {
        return DataSize(bytes: count)
    }
}
