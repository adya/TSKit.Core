// - Since: 10/02/2019
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2019. Arkadii Hlushchevskyi.
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

    /// - Returns: Date for tomorrow at the exact same time.
    func tomorrow(in calendar: Calendar = .current) -> Date {
        return calendar.date(byAdding: .day, value: 1, to: self)!
    }

    func week(_ offset: Int = 0, in calendar: Calendar = .current) -> DateInterval {
        let currentWeekday = calendar.component(.weekday, from: self)
        let weekdays = calendar.range(of: .weekday, in: .weekOfYear, for: self)!
        let firstCurrentWeekdayDistance = -(currentWeekday - calendar.firstWeekday)
        let firstOffsetWeekday = calendar.date(byAdding: .init(day: firstCurrentWeekdayDistance, weekOfYear: offset), to: self)!
                                         .startOfDay(in: calendar)
        let lastOffsetWeekday = calendar.date(byAdding: .init(day: weekdays.count, second: -1), to: firstOffsetWeekday)!
        return .init(start: firstOffsetWeekday, end: lastOffsetWeekday)
    }

    func month(_ offset: Int = 0, in calendar: Calendar = .current) -> DateInterval {
        let currentDay = calendar.component(.day, from: self)
        let firstCurrentDayDistance = -(currentDay - 1)
        let firstOffsetDay = calendar.date(byAdding: .init(month: offset, day: firstCurrentDayDistance), to: self)!
                                     .startOfDay(in: calendar)
        let lastOffsetDay = calendar.date(byAdding: .init(month: 1, second: -1), to: firstOffsetDay)!
        return .init(start: firstOffsetDay, end: lastOffsetDay)
    }
}

public struct DateInterval {

    private(set) public var start: Date

    private(set) public var end: Date

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
