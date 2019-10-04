/// - Since: 01/20/2018
/// - Authors: Arkadii Hlushchevskyi
/// - Copyright: © 2018. Arkadii Hlushchevskyi.
/// - Seealsos: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

/// Defines an interface to configure object with acceptable `DataSource`s.
public protocol Configurable {
    
    /// Generic type of the data source.
    associatedtype DataSource
    
    /// Configures itself with provided data source.
    /// - Parameter dataSource: Any object conforming to `DataSource` protocols acceptable by this `Configurable`.
    func configure(with dataSource : DataSource)
}
