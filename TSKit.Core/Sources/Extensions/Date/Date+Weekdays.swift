// - Since: 10/02/2019
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

import Foundation

public extension Date {

    /// - Returns: The very first moment of the day represented by the receiver.
    func startOfDay(in calendar: Calendar = .current) -> Date {
        return calendar.startOfDay(for: self)
    }

    /// - Returns: The very last moment of the day represented by the receiver.
    func endOfDay(in calendar: Calendar = .current) -> Date {
        return calendar.date(byAdding: .init(day: 1, second: -1), to: startOfDay(in: calendar))!
    }
}

public extension Date {

    enum Offset {
        
        case next(Int)
        
        case previous(Int)
        
        case current
        
        internal var value: Int {
            switch self {
            case .current: return 0
            case .next(let value), .previous(let value): return value
            }
        }
    }
    
    func day(_ offset: Offset, in calendar: Calendar = .current) -> Date {
        return calendar.date(byAdding: .day, value: offset.value, to: self)!
    }
    
    func week(_ offset: Offset, in calendar: Calendar = .current) -> DateInterval {
        let currentWeekday = calendar.component(.weekday, from: self)
        let weekdays = calendar.range(of: .weekday, in: .weekOfYear, for: self)!
        let firstCurrentWeekdayDistance = -(currentWeekday - calendar.firstWeekday)
        let firstOffsetWeekday = calendar.date(byAdding: .init(day: firstCurrentWeekdayDistance, weekOfYear: offset.value), to: self)!
                                         .startOfDay(in: calendar)
        let lastOffsetWeekday = calendar.date(byAdding: .init(day: weekdays.count, second: -1), to: firstOffsetWeekday)!
        return .init(start: firstOffsetWeekday, end: lastOffsetWeekday)
    }

    func month(_ offset: Offset, in calendar: Calendar = .current) -> DateInterval {
        let currentDay = calendar.component(.day, from: self)
        let firstCurrentDayDistance = -(currentDay - 1)
        let firstOffsetDay = calendar.date(byAdding: .init(month: offset.value, day: firstCurrentDayDistance), to: self)!
                                     .startOfDay(in: calendar)
        let lastOffsetDay = calendar.date(byAdding: .init(month: 1, second: -1), to: firstOffsetDay)!
        return .init(start: firstOffsetDay, end: lastOffsetDay)
    }
    
//    func year(_ offset: Offset, in calendar: Calendar = .current) -> DateInterval {
//        // TODO: Calculate year.
//    }
}

public extension Date {
    
    func tomorrow(in calendar: Calendar = .current) -> Date {
        return day(.next(1), in: calendar)
    }
    
    func yesterday(in calendar: Calendar = .current) -> Date {
        return day(.previous(1), in: calendar)
    }
}

public struct DateInterval {

    private(set) public var start: Date

    private(set) public var end: Date

    @available(iOS 10, *)
    public var dateInterval: Foundation.DateInterval {
        .init(start: start, end: end)
    }
    
    @available(iOS 10, *)
    public init(dateInterval: Foundation.DateInterval) {
        start = dateInterval.start
        end = dateInterval.end
    }

    public init(start: Date, end: Date) {
        self.start = start
        self.end = end
    }
}
