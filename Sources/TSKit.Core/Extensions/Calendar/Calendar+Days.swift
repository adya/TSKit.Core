// - Since: 01/31/2022
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md
import Foundation

public extension Calendar {
    
    /// Finds a date interval that represents a whole day of the given `date`.
    /// The interval starts at the very first moment of the day and ends at the very last moment of the same day.
    ///
    /// For example:
    /// ```
    /// let today = Date() // Jan 31, 21:30:25
    /// let day = calendar.day(for: today)
    /// print(day.start) // prints "Jan 31, 00:00:00"
    /// print(day.end) // prints "Jan 31, 23:59:59"
    /// ```
    /// - Parameter date: A Date for which a day will be calculated.
    /// - Returns: A `DateInterval` that represents the day containing given `date`.
    /// - Note: If you only need start or the end of the day use `startOfDay` or `endOfDay` respectively.
    @available(iOS 10.0, *)
    @available(macOS 10.12, *)
    func day(for date: Date) -> DateInterval? {
        guard let endOfDay = endOfDay(for: date) else { return nil }
        return .init(start: startOfDay(for: date), end: endOfDay)
    }
    
    /// Returns the last moment of a given `Date`, as a `Date`.
    /// For example:
    /// ```
    /// let current = Date() // Jan 31, 21:30:25
    /// let end = calendar.endOfDay(for: current) // Jan 31, 23:59:59
    /// ```
    /// - Parameter date: The date to search.
    /// - Returns: The last moment of the given `Date`.
    func endOfDay(for date: Date) -> Date? {
        self.date(byAdding: .init(day: 1, second: -1), to: startOfDay(for: date))
    }
}

// MARK: - Today
public extension Calendar {
    
    /// Returns current date and time as a `Date`.
    ///
    /// - Note: This is an equivalent of initializing a `Date` using the default initializer `Date()`.
    ///         `today` provided as a convenience and to complete the API for other relative days.
    /// - Seealso: `yesterday`, `tomorrow`.
    func today() -> Date { Date() }
    
    /// Returns the first moment of the current date and time, as a `Date`.
    ///
    /// For example:
    /// ```
    /// let today = calendar.today() // Jan 31, 21:30:25
    /// let start = calendar.startOfToday() // Jan 31, 00:00:00
    /// ```
    /// - Note: This is an equivalent of using `startOfDay` on a date initialized with `Date()`.
    ///         `startOfToday` provided as a convenience and to complete the API for other relative days.
    /// - Seealso: `startOfYesterday(for:)`, `startOfTomorrow(for:)`.
    func startOfToday() -> Date {
        today() ==> startOfDay(for:)
    }
    
    /// Returns the last moment of the current date and time, as a `Date`.
    ///
    /// For example:
    /// ```
    /// let today = calendar.today() // Jan 31, 21:30:25
    /// let end = calendar.endOfToday() // Jan 31, 23:59:59
    /// ```
    /// - Note: This is an equivalent of using `endOfDay` on a date initialized with `Date()`.
    ///         `endOfToday` provided as a convenience and to complete the API for other relative days.
    /// - Seealso: `endOfYesterday(for:)`, `endOfTomorrow(for:)`.
    func endOfToday() -> Date? {
        today() ==>? endOfDay(for:)
    }
}

// MARK: - Yesterday
public extension Calendar {
    
    /// Returns the same time of day for a previous day relative to a given `date`.
    ///
    /// For example:
    /// ```
    /// let today = calendar.today() // Jan 31, 21:30:25
    /// let yesterday = calendar.yesterday(for: today) // Jan 30, 21:30:25
    /// ```
    /// - Returns: `Date` representing the same time of day for the previous day.
    func yesterday(for date: Date) -> Date {
        self.date(byAdding: .day, value: -1, to: date)!
    }
    
    /// Returns the first moment of a previous day relative to a given `date`.
    ///
    /// For example:
    /// ```
    /// let today = calendar.today() // Jan 31, 21:30:25
    /// let yesterday = calendar.startOfYesterday(for: today) // Jan 30, 00:00:00
    /// ```
    /// - Returns: `Date` representing the first momentof the previous day.
    func startOfYesterday(for date: Date) -> Date {
        tomorrow(for: date) ==> startOfDay(for:)
    }
    
    /// Returns the last moment of a previous day relative to a given `date`.
    ///
    /// For example:
    /// ```
    /// let today = calendar.today() // Jan 31, 21:30:25
    /// let yesterday = calendar.endOfYesterday(for: today) // Jan 30, 23:59:59
    /// ```
    /// - Returns: `Date` representing the last moment of the previous day.
    func endOfYesterday(for date: Date) -> Date? {
        tomorrow(for: date) ==>? endOfDay(for:)
    }
}

// MARK: - Tomorrow
public extension Calendar {
    
    /// Returns the same time of day for a next day relative to a given `date`.
    ///
    /// For example:
    /// ```
    /// let today = calendar.today() // Jan 31, 21:30:25
    /// let tomorrow = calendar.tomorrow(for: today) // Feb 1, 21:30:25
    /// ```
    /// - Returns: `Date` representing the same time of day for the previous day.
    func tomorrow(for date: Date) -> Date {
        self.date(byAdding: .day, value: 1, to: date)!
    }
    
    /// Returns the first moment of a next day relative to a given `date`.
    ///
    /// For example:
    /// ```
    /// let today = calendar.today() // Jan 31, 21:30:25
    /// let tomorrow = calendar.startOfTomorrow(for: today) // Feb 1, 00:00:00
    /// ```
    /// - Returns: `Date` representing the first momentof the previous day.
    func startOfTomorrow(for date: Date) -> Date {
        tomorrow(for: date) ==> startOfDay(for:)
    }
    
    /// Returns the last moment of a previous day relative to a given `date`.
    ///
    /// For example:
    /// ```
    /// let today = calendar.today() // Jan 31, 21:30:25
    /// let tomorrow = calendar.endOfTomorrow(for: today) // Feb 1, 23:59:59
    /// ```
    /// - Returns: `Date` representing the last moment of the next day.
    func endOfTomorrow(for date: Date) -> Date? {
        tomorrow(for: date) ==>? endOfDay(for:)
    }
}
