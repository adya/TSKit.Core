// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2019. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

/// Defines an interface to configure object with acceptable `DataSource`s.
public protocol Configurable {
    
    /// Generic type of the data source.
    associatedtype DataSource
    
    /// Configures itself with provided data source.
    /// - Parameter dataSource: Any object conforming to `DataSource` protocols acceptable by this `Configurable`.
    func configure(with dataSource : DataSource)
}
