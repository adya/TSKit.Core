// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2019. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

public extension Date {
    
    /// Returns boolean value indicating whether the difference between specified date and `self` is bigger than or
    /// equals `days` value.
    /// - Parameter date: `Date` to be counted to.
    /// - Returns: `true` if difference is bigger than or equals `days` value, otherwise `false`.
    func isLater(than date: Date, by days: Int) -> Bool {
        return Calendar.current.dateComponents([.day], from: self, to: date).day ?? 0 >= days
    }
}

/// Checks whether the first date is greater than or equal to the second date by comparing all date components
@available(iOS 8.0, *)
public func >=(date1 : Date, date2 : Date) -> Bool {
    let res = date1.compare(date2)
    return res == .orderedDescending || res == .orderedSame
}

/// Checks whether the first date is less than or equal to the second date by comparing all date components
@available(iOS 8.0, *)
public func <=(date1 : Date, date2 : Date) -> Bool {
    let res = date1.compare(date2)
    return res == .orderedAscending || res == .orderedSame
}

/// Checks whether the first date is not equal to the second date by comparing all date components
@available(iOS 8.0, *)
public func !=(date1 : Date, date2 : Date) -> Bool {
    return date1.compare(date2) != .orderedSame
}

// TODO: Enhance min/max to support varying arguments.

/// Finds minimum of two dates by comparing all date components
public func min(_ x : Date, y: Date) -> Date {
    return (x < y ? x : y)
}

/// Finds maximum of two dates by comparing all date components
public func max(_ x : Date, y: Date) -> Date {
    return (x > y ? x : y)
}
/// Finds minimum of two dates by comparing only date components (e.g. Year, Month, Day)
public func minDate(_ x : Date, y: Date) -> Date {
    return (x <! y ? x : y)
}

/// Finds maximum of two dates by comparing only date components (e.g. Year, Month, Day)
public func maxDate(_ x : Date, y: Date) -> Date {
    return (x >! y ? x : y)
}

/// Date comparison operators to compare with .Day granularity
infix operator >! : ComparisonPrecedence
infix operator >=! : ComparisonPrecedence
infix operator <! : ComparisonPrecedence
infix operator <=! : ComparisonPrecedence
infix operator ==! : ComparisonPrecedence
infix operator !=! : ComparisonPrecedence

private func compareDates(_ date1 : Date, date2 : Date, granularity : Calendar.Component) -> ComparisonResult {
    return Calendar.current.compare(date1, to: date2, toGranularity: granularity)
}

/// Checks whether the first date is greater than the second date by comparing only their date components (e.g. Year, Month, Day)
@available(iOS 8.0, *)
public func >!(date1 : Date, date2 : Date) -> Bool {
    return compareDates(date1, date2: date2, granularity: .day) == .orderedDescending
}

/// Checks whether the first date is greater than or equal to the second date by comparing only their date components (e.g. Year, Month, Day)
@available(iOS 8.0, *)
public func >=!(date1 : Date, date2 : Date) -> Bool {
    let res = compareDates(date1, date2: date2, granularity: .day)
    return res == .orderedDescending || res == .orderedSame
}

/// Checks whether the first date is less than the second date by comparing only their date components (e.g. Year, Month, Day)
@available(iOS 8.0, *)
public func <!(date1 : Date, date2 : Date) -> Bool {
    return compareDates(date1, date2: date2, granularity: .day) == .orderedAscending
}

/// Checks whether the first date is less than or equal to the second date by comparing only their date components (e.g. Year, Month, Day)
@available(iOS 8.0, *)
public func <=!(date1 : Date, date2 : Date) -> Bool {
    let res = compareDates(date1, date2: date2, granularity: .day)
    return res == .orderedAscending || res == .orderedSame
}

/// Checks whether the first date is equal to the second date by comparing only their date components (e.g. Year, Month, Day)
@available(iOS 8.0, *)
public func ==!(date1 : Date, date2 : Date) -> Bool {
    return compareDates(date1, date2: date2, granularity: .day) == .orderedSame
}

/// Checks whether the first date is not equal to the second date by comparing only their date components (e.g. Year, Month, Day)
@available(iOS 8.0, *)
public func !=!(date1 : Date, date2 : Date) -> Bool {
    return compareDates(date1, date2: date2, granularity: .day) != .orderedSame
}
