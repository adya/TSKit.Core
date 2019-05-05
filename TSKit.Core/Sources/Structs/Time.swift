/// - Since: 01/20/2018
/// - Author: Arkadii Hlushchevskyi
/// - Copyright: © 2019. Arkadii Hlushchevskyi.
/// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

// TODO: Refactor to use Int64 only when needed.
// TODO: Add support for `hours`.

// TODO: Create same thing for date intervals.

/// Simple struct representing time interval.
public struct Time: Comparable {

    /// Minutes portion of this time interval.
    public let minutes : Int64

    /// Seconds portion of this time interval.
    public let seconds : Int64

    /// Milliseconds portion of this time interval.
    public let millis : Int64

    public init(minutes: Int64 = 0, seconds: Int64 = 0, milliseconds: Int64 = 0) {

        let extraSeconds = milliseconds / 1000
        let totalSeconds = seconds + extraSeconds

        let millisReminder = milliseconds - extraSeconds * 1000

        let extraMinutes = totalSeconds / 60
        let totalMinutes = minutes + extraMinutes

        let secondsReminder = totalSeconds - extraMinutes * 60

        self.minutes = totalMinutes
        self.seconds = secondsReminder
        self.millis = millisReminder
    }
}

// MARK: - Operators
public func - (lhs : Time, rhs : Time) -> Time {
    return Time(milliseconds: abs(lhs.totalMillis - rhs.totalMillis))
}

public func + (lhs : Time, rhs : Time) -> Time {
    return Time(milliseconds: lhs.totalMillis + rhs.totalMillis)
}

public func += (lhs : inout Time, rhs : Time) {
    lhs = lhs + rhs
}

public func -= (lhs : inout Time, rhs : Time) {
    lhs = lhs - rhs
}

public func == (lhs : Time, rhs : Time) -> Bool {
    return lhs.totalMillis == rhs.totalMillis
}

public func < (lhs: Time, rhs: Time) -> Bool {
    return lhs.totalMillis < rhs.totalMillis
}

// MARK: - Handy properties
public extension Time {

    /// Total number of seconds in this time interval.
    public var totalSeconds : Int64 {
        return minutes * 60 + seconds
    }

    /// Total number of milliseconds in this time interval.
    public var totalMillis : Int64 {
        return totalSeconds * 1000 + millis
    }
}

// MARK: - String convertibles
extension Time : CustomStringConvertible {

    /// String representation in format `mm:ss.ccc`
    public var description: String {
        return String(format: "%02lld:%02lld.%03lld", minutes, seconds, millis)
    }

    /// String representation in format `mm:ss`
    public var shortDescription : String {
        return String(format: "%02lld:%02lld", minutes, seconds)
    }
}
