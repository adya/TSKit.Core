// - Since: 07/18/2022
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

import Combine

@available(iOS 13.0, macOS 10.15, tvOS 13.0, *)
public extension Sequence where Element: Publisher {

    /// Combines elements from publishers in the sequence, delivering an interleaved sequence of elements.
    /// - Returns: A publisher that emits an event when one of the upstream publishers emits an event.
    func merge() -> Publishers.MergeMany<Element> {
        Publishers.MergeMany(self)
    }
}
