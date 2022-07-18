// - Since: 10/02/2019
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md
import Foundation

public extension Date {

    /// Returns the first moment of a given `Date`, as a `Date`.
    /// For example:
    /// ```
    /// let current = Date() // Jan 31, 21:30:25
    /// let start = current.startOfDay() // Jan 31, 00:00:00
    /// ```
    /// - Parameter calendar: Calendar that will be used to calculate the start of day. Defaults to `.current`.
    /// - Returns: The first moment of the given `Date`.
    @available(*, deprecated, message: "Use Calendar.startOfDay instead")
    func startOfDay(in calendar: Calendar = .current) -> Date {
        calendar.startOfDay(for: self)
    }

    /// Returns the last moment of a given `Date`, as a `Date`.
    /// For example:
    /// ```
    /// let current = Date() // Jan 31, 21:30:25
    /// let end = current.endOfDay() // Jan 31, 23:59:59
    /// ```
    /// - Parameter calendar: Calendar that will be used to calculate the end of day. Defaults to `.current`.
    /// - Returns: The last moment of the given `Date`.
    @available(*, deprecated, message: "Use Calendar.endOfDay instead")
    func endOfDay(in calendar: Calendar = .current) -> Date {
        calendar.endOfDay(for: self)!
    }
}

public extension Date {

    /// - Returns: Date for tomorrow at the exact same time.
    @available(*, deprecated, message: "Use Calendar.tomorrow(for:) instead")
    func tomorrow(in calendar: Calendar = .current) -> Date {
        calendar.tomorrow(for: self)
    }

    @available(*, deprecated, message: "Use Calendar.week(for:offset:) instead")
    @available(iOS 10.0, macOS 10.12, tvOS 10.0, *)
    func week(_ offset: Int = 0, in calendar: Calendar = .current) -> DateInterval {
        calendar.week(for: self, offset: offset)!
    }

    @available(*, deprecated, message: "Use Calendar.month(for:offset:) instead")
    @available(iOS 10.0, macOS 10.12, tvOS 10.0, *)
    func month(_ offset: Int = 0, in calendar: Calendar = .current) -> DateInterval {
        calendar.month(for: self, offset: offset)!
    }
    
    @available(*, deprecated, message: "Use Calendar.startOfMonth(for:offset:) instead")
    func startOfMonth(in calendar: Calendar = .current) -> Date? {
        calendar.startOfMonth(for: self, offset: 0)
    }
    
    @available(*, deprecated, message: "Use Calendar.endOfMonth(for:offset:) instead")
    func endOfMonth(in calendar: Calendar = .current) -> Date? {
        calendar.endOfMonth(for: self, offset: 0)
    }
}
