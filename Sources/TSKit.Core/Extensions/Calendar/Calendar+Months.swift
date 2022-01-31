// - Since: 01/31/2022
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md
import Foundation

// MARK: - Current month
public extension Calendar {
    
    /// Finds a date interval that represents a current month that given `date` is a part of.
    ///
    /// For example:
    /// ```
    /// let today = Date() // Jan 31, 21:30:25
    /// let month = calendar.currentMonth(for: today)
    /// print(month.start) // prints "Jan 1, 00:00:00"
    /// print(month.end) // prints "Jan 31, 23:59:59"
    /// ```
    /// - Parameter date: A Date relatively to which a month will be calculated.
    /// - Returns: A `DateInterval` that represents the month containing given `date`.
    /// - Note: This is an equivalent of calling `month(for: date, offset: 0)`.
    @available(iOS 10.0, *)
    @available(macOS 10.12, *)
    func currentMonth(for date: Date) -> DateInterval? {
        month(for: date, offset: 0)
    }
    
    /// Finds a date that is the first moment of a current month that given `date` is a part of.
    ///
    /// For example:
    /// ```
    /// let today = Date() // Jan 31, 21:30:25
    /// let start = calendar.startOfCurrentMonth(for: today)
    /// print(start) // prints "Jan 1, 00:00:00"
    /// ```
    /// - Parameter date: A Date relatively to which a month will be calculated.
    /// - Returns: A `Date` that is the first moment of the month containing given `date`.
    /// - Note: This is an equivalent of calling `startOfMonth(for: date, offset: 0)`.
    func startOfCurrentMonth(for date: Date) -> Date? {
        startOfMonth(for: date, offset: 0)
    }
    
    /// Finds a date that is the last moment of a current month that given `date` is a part of.
    ///
    /// For example:
    /// ```
    /// let today = Date() // Jan 31, 21:30:25
    /// let end = calendar.endOfCurrentMonth(for: today)
    /// print(end) // prints "Jan 31, 23:59:59"
    /// ```
    /// - Parameter date: A Date relatively to which a month will be calculated.
    /// - Returns: A `Date` that is the last moment of the month containing given `date`.
    /// - Note: This is an equivalent of calling `endOfMonth(for: date, offset: 0)`.
    func endOfCurrentMonth(for date: Date) -> Date? {
        endOfMonth(for: date, offset: 0)
    }
}

// MARK: - Previous month
public extension Calendar {
    
    /// Finds a date interval that represents a previous month relatively to the month that given `date` is a part of.
    ///
    /// For example:
    /// ```
    /// let today = Date() // Jan 31, 21:30:25
    /// let month = calendar.previousMonth(for: today)
    /// print(month.start) // prints "Dec 1, 00:00:00"
    /// print(month.end) // prints "Dec 31, 23:59:59"
    /// ```
    /// - Parameter date: A Date relatively to which a month will be calculated.
    /// - Returns: A `DateInterval` that represents the previous month.
    /// - Note: This is an equivalent of calling `month(for: date, offset: -1)`.
    @available(iOS 10.0, *)
    @available(macOS 10.12, *)
    func previousMonth(for date: Date) -> DateInterval? {
        month(for: date, offset: -1)
    }
    
    /// Finds a date that is the first moment of a previous month relatively to the month that given `date` is a part of.
    ///
    /// For example:
    /// ```
    /// let today = Date() // Jan 31, 21:30:25
    /// let start = calendar.startOfPreviousMonth(for: today)
    /// print(start) // prints "Dec 1, 00:00:00"
    /// ```
    /// - Parameter date: A Date relatively to which a month will be calculated.
    /// - Returns: A `Date` that is the first moment of the previous month.
    /// - Note: This is an equivalent of calling `startOfMonth(for: date, offset: -1)`.
    func startOfPreviousMonth(for date: Date) -> Date? {
        startOfMonth(for: date, offset: -1)
    }
    
    /// Finds a date that is the last moment of a previous month relatively to the month that given `date` is a part of.
    ///
    /// For example:
    /// ```
    /// let today = Date() // Jan 31, 21:30:25
    /// let end = calendar.endOfPreviousMonth(for: today)
    /// print(end) // prints "Dec 31, 23:59:59"
    /// ```
    /// - Parameter date: A Date relatively to which a month will be calculated.
    /// - Returns: A `Date` that is the last moment of the previous month.
    /// - Note: This is an equivalent of calling `endOfMonth(for: date, offset: -1)`.
    func endOfPreviousMonth(for date: Date) -> Date? {
        endOfMonth(for: date, offset: -1)
    }
}

// MARK: - Next month
public extension Calendar {
    
    /// Finds a date interval that represents a next month relatively to the month that given `date` is a part of.
    ///
    /// For example:
    /// ```
    /// let today = Date() // Jan 31, 21:30:25
    /// let month = calendar.nextMonth(for: today)
    /// print(month.start) // prints "Feb 1, 00:00:00"
    /// print(month.end) // prints "Feb 28, 23:59:59"
    /// ```
    /// - Parameter date: A Date relatively to which a month will be calculated.
    /// - Returns: A `DateInterval` that represents the next month.
    /// - Note: This is an equivalent of calling `month(for: date, offset: 1)`.
    @available(iOS 10.0, *)
    @available(macOS 10.12, *)
    func nextMonth(for date: Date) -> DateInterval? {
        month(for: date, offset: 1)
    }
    
    /// Finds a date that is the first moment of a next month relatively to the month that given `date` is a part of.
    ///
    /// For example:
    /// ```
    /// let today = Date() // Jan 31, 21:30:25
    /// let start = calendar.startOfNextMonth(for: today)
    /// print(start) // prints "Feb 1, 00:00:00"
    /// ```
    /// - Parameter date: A Date relatively to which a month will be calculated.
    /// - Returns: A `Date` that is the first moment of the next month.
    /// - Note: This is an equivalent of calling `startOfMonth(for: date, offset: 1)`.
    func startOfNextMonth(for date: Date) -> Date? {
        startOfMonth(for: date, offset: 1)
    }
    
    /// Finds a date that is the last moment of a next month relatively to the month that given `date` is a part of.
    ///
    /// For example:
    /// ```
    /// let today = Date() // Jan 31, 21:30:25
    /// let end = calendar.endOfNextMonth(for: today)
    /// print(end) // prints "Feb 28, 23:59:59"
    /// ```
    /// - Parameter date: A Date relatively to which a month will be calculated.
    /// - Returns: A `Date` that is the last moment of the next month.
    /// - Note: This is an equivalent of calling `endOfMonth(for: date, offset: 1)`.
    func endOfNextMonth(for date: Date) -> Date? {
        endOfMonth(for: date, offset: 1)
    }
}

// MARK: - Any month
public extension Calendar {
    
    /// Finds a date interval that represents a month that given `date` is a part of.
    ///
    /// For example:
    /// ```
    /// let today = Date() // Jan 31, 21:30:25
    /// let month = calendar.month(for: today, offset: 2)
    /// print(month.start) // prints "Mar 1, 00:00:00"
    /// print(month.end) // prints "Mar 31, 23:59:59"
    /// ```
    /// - Parameter date: A Date relatively to which a month will be calculated.
    /// - Parameter offset: A number of months to offset from the month that contains given `date`.
    ///                      For example, an `offset: 1` would find a next month relative to given date.
    /// - Returns: A `DateInterval` that represents the month containing given `date`.
    /// - Note: If you only need start or the end of the month use `startOfMonth` or `endOfMonth` respectively.
    @available(iOS 10.0, *)
    @available(macOS 10.12, *)
    func month(for date: Date, offset: Int) -> DateInterval? {
        guard let startOfMonth = startOfMonth(for: date, offset: offset),
              let endOfMonth = endOfMonth(startingOn: startOfMonth) else {
                  return nil
              }
        return .init(start: startOfMonth, end: endOfMonth)
    }
                                         
    /// Finds a date that is the first moment of a month that given `date` is a part of.
    ///
    /// For example:
    /// ```
    /// let today = Date() // Jan 31, 21:30:25
    /// let start = calendar.startOfMonth(for: today, offset: 2)
    /// print(start) // prints "Mar 1, 00:00:00"
    /// ```
    /// - Parameter date: A Date relatively to which a month will be calculated.
    /// - Parameter offset: A number of months to offset from the month that contains given `date`.
    ///                      For example, an `offset: 1` would find a next month relative to given date.
    /// - Returns: A `Date` that is the first moment of the month containing given `date`.
    /// - Note: If you only need start or the end of the month use `startOfMonth(for:offset:)` or `endOfMonth(for:offset:)` respectively.
    func startOfMonth(for date: Date, offset: Int) -> Date? {
        dateComponents([.year, .month], from: date)
        ==> { self.date(from: $0) }
        ==>? { self.date(byAdding: .month, value: offset, to: $0) }
    }
        
    /// Finds a date that is the last moment of a month that given `date` is a part of.
    ///
    /// For example:
    /// ```
    /// let today = Date() // Jan 31, 21:30:25
    /// let end = calendar.endOfMonth(for: today, offset: 2)
    /// print(end) // prints "Mar 31, 23:59:59"
    /// ```
    /// - Parameter date: A Date relatively to which a month will be calculated.
    /// - Parameter offset: A number of months to offset from the month that contains given `date`.
    ///                      For example, an `offset: 1` would find a next month relative to given date.
    /// - Returns: A `Date` that is the last moment of the month containing given `date`.
    /// - Note: If you also need a start of the month use `month(for:offset:)` instead.
    func endOfMonth(for date: Date, offset: Int) -> Date? {
        endOfMonth(startingOn: startOfMonth(for: date, offset: offset))
    }
    
    /// Helper method that allows optimizing `month` method by avoiding extra calculation of `startOfMonth`.
    private func endOfMonth(startingOn startOfMonth: Date?) -> Date? {
        startOfMonth.flatMap { date(byAdding: .init(month: 1, second: -1), to: $0) }
    }
}
