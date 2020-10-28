// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

import Foundation

@available(iOS 8.0, *)
public extension Date {
    
    init?(from dateString: String,
          formattedWith targetFormat: String,
          with calendarIdentifier: Calendar.Identifier? = nil,
          in timezone: TimeZone = TimeZone.current) {
        let formatter = DateFormatter()
        if let calendar = calendarIdentifier.flatMap(Calendar.init(identifier:)) {
            formatter.calendar = calendar
        }
        formatter.dateFormat = targetFormat
        formatter.timeZone = timezone
        guard let date = formatter.date(from: dateString) else { return nil }
        
        self = date
    }
    
    func toString(withFormat targetFormat : String,
                  andTimezone timezone : TimeZone = TimeZone.current) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = targetFormat
        formatter.timeZone = timezone
        return formatter.string(from: self)
    }
}

@available(iOS 8.0, *)
public extension String {
    
    init?(from date: Date,
          formattedWith dateFormat: String,
          with calendarIdentifier: Calendar.Identifier? = nil,
          in timezone: TimeZone = .current) {
        
        let formatter = DateFormatter()
        if let calendar = calendarIdentifier.flatMap(Calendar.init(identifier:)) {
            formatter.calendar = calendar
        }
        formatter.dateFormat = dateFormat
        formatter.timeZone = timezone
        let stringDate = formatter.string(from: date)
        guard !stringDate.isEmpty else { return nil }
        
        self = stringDate
    }
    
    init?(from date: Date,
          dateStyle: DateFormatter.Style = .short,
          timeStyle: DateFormatter.Style = .short,
          in timezone: TimeZone = .current) {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        formatter.timeZone = timezone
        
        let stringDate = formatter.string(from: date)
        guard !stringDate.isEmpty else { return nil }
        
        self = stringDate
    }
    
    @available(iOS 8.0, *)
    func reformattingDate(formattedWith sourceFormat: String,
                          with sourceCalendarIdentifier: Calendar.Identifier? = nil,
                          `in` sourceTimezone: TimeZone = TimeZone.current,
                          toStringFormattedWith targetFormat: String,
                          with targetCalendarIdentifier: Calendar.Identifier? = nil,
                          `in` targetTimezone: TimeZone = TimeZone.current) -> String? {
        if let date = Date(from: self, formattedWith: sourceFormat, with: sourceCalendarIdentifier, in: sourceTimezone) {
            return String(from: date, formattedWith: targetFormat, with: targetCalendarIdentifier, in: targetTimezone)
        }
        return nil
    }
    
    @available(iOS 8.0, *)
    mutating func reformatDate(formattedWith sourceFormat: String,
                               `in` sourceTimezone: TimeZone = TimeZone.current,
                               toStringFormattedWith targetFormat: String,
                               `in` targetTimezone: TimeZone = TimeZone.current) {
        guard let date = Date(from: self, formattedWith: sourceFormat, in: sourceTimezone),
            let newStringDate = String(from: date, formattedWith: targetFormat, in: targetTimezone) else {
                return
        }
        self = newStringDate
    }
}
