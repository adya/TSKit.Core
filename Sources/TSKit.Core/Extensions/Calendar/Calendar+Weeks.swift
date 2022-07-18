// - Since: 01/31/2022
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md
import Foundation

// MARK: - Current week
public extension Calendar {
    
    /// Finds a date interval that represents a current week that given `date` is a part of.
    ///
    /// For example:
    /// ```
    /// let today = Date() // Jan 31, 21:30:25
    /// let week = calendar.currentWeek(for: today)
    /// print(week.start) // prints "Jan 31, 00:00:00"
    /// print(week.end) // prints "Feb 6, 23:59:59"
    /// ```
    /// - Parameter date: A Date relatively to which a week will be calculated.
    /// - Returns: A `DateInterval` that represents the week containing given `date`.
    /// - Note: This is an equivalent of calling `week(for: date, offset: 0)`.
    @available(iOS 10.0, macOS 10.12, tvOS 10.0, *)
    func currentWeek(for date: Date) -> DateInterval? {
        week(for: date, offset: 0)
    }
    
    /// Finds a date that is the first moment of a current week that given `date` is a part of.
    ///
    /// For example:
    /// ```
    /// let today = Date() // Jan 31, 21:30:25
    /// let start = calendar.startOfCurrentWeek(for: today)
    /// print(start) // prints "Jan 31, 00:00:00"
    /// ```
    /// - Parameter date: A Date relatively to which a week will be calculated.
    /// - Returns: A `Date` that is the first moment of the week containing given `date`.
    /// - Note: This is an equivalent of calling `startOfWeek(for: date, offset: 0)`.
    func startOfCurrentWeek(for date: Date) -> Date? {
        startOfWeek(for: date, offset: 0)
    }
    
    /// Finds a date that is the last moment of a current week that given `date` is a part of.
    ///
    /// For example:
    /// ```
    /// let today = Date() // Jan 31, 21:30:25
    /// let end = calendar.endOfCurrentWeek(for: today)
    /// print(end) // prints "Feb 6, 23:59:59"
    /// ```
    /// - Parameter date: A Date relatively to which a week will be calculated.
    /// - Returns: A `Date` that is the last moment of the week containing given `date`.
    /// - Note: This is an equivalent of calling `endOfWeek(for: date, offset: 0)`.
    func endOfCurrentWeek(for date: Date) -> Date? {
        endOfWeek(for: date, offset: 0)
    }
}

// MARK: - Previous week
public extension Calendar {
    
    /// Finds a date interval that represents a previous week relatively to the week that given `date` is a part of.
    ///
    /// For example:
    /// ```
    /// let today = Date() // Jan 31, 21:30:25
    /// let week = calendar.previousWeek(for: today)
    /// print(week.start) // prints "Jan 24, 00:00:00"
    /// print(week.end) // prints "Jan 30, 23:59:59"
    /// ```
    /// - Parameter date: A Date relatively to which a week will be calculated.
    /// - Returns: A `DateInterval` that represents the previous week.
    /// - Note: This is an equivalent of calling `week(for: date, offset: -1)`.
    @available(iOS 10.0, macOS 10.12, tvOS 10.0, *)
    func previousWeek(for date: Date) -> DateInterval? {
        week(for: date, offset: -1)
    }
    
    /// Finds a date that is the first moment of a previous week relatively to the week that given `date` is a part of.
    ///
    /// For example:
    /// ```
    /// let today = Date() // Jan 31, 21:30:25
    /// let start = calendar.startOfPreviousWeek(for: today)
    /// print(start) // prints "Jan 24, 00:00:00"
    /// ```
    /// - Parameter date: A Date relatively to which a week will be calculated.
    /// - Returns: A `Date` that is the first moment of the previous week.
    /// - Note: This is an equivalent of calling `startOfWeek(for: date, offset: -1)`.
    func startOfPreviousWeek(for date: Date) -> Date? {
        startOfWeek(for: date, offset: -1)
    }
    
    /// Finds a date that is the last moment of a previous week relatively to the week that given `date` is a part of.
    ///
    /// For example:
    /// ```
    /// let today = Date() // Jan 31, 21:30:25
    /// let end = calendar.endOfPreviousWeek(for: today)
    /// print(end) // prints "Jan 30, 23:59:59"
    /// ```
    /// - Parameter date: A Date relatively to which a week will be calculated.
    /// - Returns: A `Date` that is the last moment of the previous week.
    /// - Note: This is an equivalent of calling `endOfWeek(for: date, offset: -1)`.
    func endOfPreviousWeek(for date: Date) -> Date? {
        endOfWeek(for: date, offset: -1)
    }
}

// MARK: - Next week
public extension Calendar {
    
    /// Finds a date interval that represents a next week relatively to the week that given `date` is a part of.
    ///
    /// For example:
    /// ```
    /// let today = Date() // Jan 31, 21:30:25
    /// let week = calendar.nextWeek(for: today)
    /// print(week.start) // prints "Feb 7, 00:00:00"
    /// print(week.end) // prints "Feb 13, 23:59:59"
    /// ```
    /// - Parameter date: A Date relatively to which a week will be calculated.
    /// - Returns: A `DateInterval` that represents the next week.
    /// - Note: This is an equivalent of calling `week(for: date, offset: 1)`.
    @available(iOS 10.0, macOS 10.12, tvOS 10.0, *)
    func nextWeek(for date: Date) -> DateInterval? {
        week(for: date, offset: 1)
    }
    
    /// Finds a date that is the first moment of a next week relatively to the week that given `date` is a part of.
    ///
    /// For example:
    /// ```
    /// let today = Date() // Jan 31, 21:30:25
    /// let start = calendar.startOfNextWeek(for: today)
    /// print(start) // prints "Feb 7, 00:00:00"
    /// ```
    /// - Parameter date: A Date relatively to which a week will be calculated.
    /// - Returns: A `Date` that is the first moment of the next week.
    /// - Note: This is an equivalent of calling `startOfWeek(for: date, offset: 1)`.
    func startOfNextWeek(for date: Date) -> Date? {
        startOfWeek(for: date, offset: 1)
    }
    
    /// Finds a date that is the last moment of a next week relatively to the week that given `date` is a part of.
    ///
    /// For example:
    /// ```
    /// let today = Date() // Jan 31, 21:30:25
    /// let end = calendar.endOfNextWeek(for: today)
    /// print(end) // prints "Feb 13, 23:59:59"
    /// ```
    /// - Parameter date: A Date relatively to which a week will be calculated.
    /// - Returns: A `Date` that is the last moment of the next week.
    /// - Note: This is an equivalent of calling `endOfWeek(for: date, offset: 1)`.
    func endOfNextWeek(for date: Date) -> Date? {
        endOfWeek(for: date, offset: 1)
    }
}

// MARK: - Any week
public extension Calendar {
    
    /// Finds a date interval that represents a week that given `date` is a part of.
    ///
    /// For example:
    /// ```
    /// let today = Date() // Jan 31, 21:30:25
    /// let week = calendar.week(for: today, offset: 2)
    /// print(week.start) // prints "Feb 14, 00:00:00"
    /// print(week.end) // prints "Feb 20, 23:59:59"
    /// ```
    /// - Parameter date: A Date relatively to which a week will be calculated.
    /// - Parameter offset: A number of weeks to offset from the week that contains given `date`.
    ///                      For example, an `offset: 1` would find a next week relative to given date.
    /// - Returns: A `DateInterval` that represents the week containing given `date`.
    /// - Note: If you only need start or the end of the week use `startOfWeek` or `endOfWeek` respectively.
    @available(iOS 10.0, macOS 10.12, tvOS 10.0, *)
    func week(for date: Date, offset: Int) -> DateInterval? {
        guard let startOfWeek = startOfWeek(for: date, offset: offset),
              let endOfWeek = endOfWeek(for: date, offset: offset) else {
                  return nil
              }
        return .init(start: startOfWeek, end: endOfWeek)
    }
    
    /// Finds a date that is the first moment of a week that given `date` is a part of.
    ///
    /// For example:
    /// ```
    /// let today = Date() // Jan 31, 21:30:25
    /// let start = calendar.startOfWeek(for: today, offset: 2)
    /// print(start) // prints "Feb 14, 00:00:00"
    /// ```
    /// - Parameter date: A Date relatively to which a week will be calculated.
    /// - Parameter offset: A number of weeks to offset from the week that contains given `date`.
    ///                      For example, an `offset: 1` would find a next week relative to given date.
    /// - Returns: A `Date` that is the first moment of the week containing given `date`.
    /// - Note: If you only need start or the end of the week use `startOfWeek(for:offset:)` or `endOfWeek(for:offset:)` respectively.
    func startOfWeek(for date: Date, offset: Int) -> Date? {
        dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
        ==> { self.date(from: $0) }
        ==>? { self.date(byAdding: .weekOfYear, value: offset, to: $0) }
    }
    
    /// Finds a date that is the last moment of a week that given `date` is a part of.
    ///
    /// For example:
    /// ```
    /// let today = Date() // Jan 31, 21:30:25
    /// let end = calendar.endOfWeek(for: today, offset: 2)
    /// print(end) // prints "Feb 20, 23:59:59"
    /// ```
    /// - Parameter date: A Date relatively to which a week will be calculated.
    /// - Parameter offset: A number of weeks to offset from the week that contains given `date`.
    ///                      For example, an `offset: 1` would find a next week relative to given date.
    /// - Returns: A `Date` that is the last moment of the week containing given `date`.
    /// - Note: If you also need a start of the week use `week(for:offset:)` instead.
    func endOfWeek(for date: Date, offset: Int) -> Date? {
        endOfWeek(startingOn: startOfWeek(for: date, offset: offset))
    }
    
    /// Helper method that allows optimizing `week` method by avoiding extra calculation of `startOfWeek`.
    private func endOfWeek(startingOn startOfWeek: Date?) -> Date? {
        startOfWeek.flatMap { date(byAdding: .init(second: -1, weekOfYear: 1), to: $0) }
    }
}
