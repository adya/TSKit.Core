// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2019. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

/// Components of the day
public enum DateComponents {
    case days(Int), months(Int), years(Int)
    case hours(Int), minutes(Int), seconds(Int), nanoseconds(Int)
    
}

public extension Date {
    
    /// Creates new date by extracting specified date components from `self`.
    @available(iOS 8.0, *)
    func date(with dateComponents: [Calendar.Component]) -> Date {
        let comps = Calendar.current.dateComponents(Set<Calendar.Component>(dateComponents), from: self)
        return Calendar.current.date(from: comps)!
    }
    
    /// Returns date with date components only.
    @available(iOS 8.0, *)
    var onlyDate: Date {
        return self.date(with: [.year, .month, .day])
    }
    
    /// Returns date with time components only.
    @available(iOS 8.0, *)
    var onlyTime: Date {
        return self.date(with: [.hour, .minute, .second])
    }
    
    /// Returns date with time components only including nanoseconds.
    @available(iOS 8.0, *)
    var preciseTime: Date {
        return self.date(with: [.hour, .minute, .second, .nanosecond])
    }
}

/// Subtracts given components from the date and returns resulting date.
@available(iOS 8.0, *)
public func -(date : Date, dateComponents: [DateComponents]) -> Date? {
    var comps = Foundation.DateComponents()
    for dateComponent in dateComponents {
        switch dateComponent {
        case .days(let days):
            comps.day = (days > 0 ? -days : days)
        case .months(let months):
            comps.month = (months > 0 ? -months : months)
        case .years(let years):
            comps.year = (years > 0 ? -years : years)
        case .hours(let hours):
            comps.hour = (hours > 0 ? -hours : hours)
        case .minutes(let mins):
            comps.minute = (mins > 0 ? -mins : mins)
        case .seconds(let secs):
            comps.second = (secs > 0 ? -secs : secs)
        case .nanoseconds(let nsecs):
            comps.nanosecond = (nsecs > 0 ? -nsecs : nsecs)
        }
    }
    return (Calendar.current as NSCalendar).date(byAdding: comps, to: date, options: [])
}

/// Adds given components to the date and returns resulting date.
@available(iOS 8.0, *)
public func +(date : Date, dateComponents: [DateComponents]) -> Date? {
    var comps = Foundation.DateComponents()
    for dateComponent in dateComponents {
        switch dateComponent {
        case .days(let days):
            comps.day = days
        case .months(let months):
            comps.month = months
        case .years(let years):
            comps.year = years
        case .hours(let hours):
            comps.hour = hours
        case .minutes(let mins):
            comps.minute = mins
        case .seconds(let secs):
            comps.second = secs
        case .nanoseconds(let nsecs):
            comps.nanosecond = nsecs
        }
    }
    return (Calendar.current as NSCalendar).date(byAdding: comps, to: date, options: [])
}

/// Subtracts given component from the date and returns resulting date.
@available(iOS 8.0, *)
public func -(date : Date, dateComponent: DateComponents) -> Date? {
    return date - [dateComponent]
}

/// Adds given component to the date and returns resulting date.
@available(iOS 8.0, *)
public func +(date : Date, dateComponent: DateComponents) -> Date? {
    return date + [dateComponent]
}
