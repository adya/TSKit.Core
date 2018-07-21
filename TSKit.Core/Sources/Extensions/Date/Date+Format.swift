/// TSTOOLS:  Description... 9/19/16.
import Foundation

@available(iOS 8.0, *)
public extension Date {
    
    public init?(from dateString: String,
                 formattedWith targetFormat: String,
                 in timezone: TimeZone = TimeZone.current) {
        let formatter = DateFormatter()
        formatter.dateFormat = targetFormat
        formatter.timeZone = timezone
        guard let date = formatter.date(from: dateString) else { return nil }
        
        self = date
    }
    
    public func toString(withFormat targetFormat : String,
                         andTimezone timezone : TimeZone = TimeZone.current) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = targetFormat
        formatter.timeZone = timezone
        return formatter.string(from: self)
    }
}

@available(iOS 8.0, *)
public extension String {
    
    public init?(from date: Date,
                 formattedWith dateFormat: String,
                 in timezone: TimeZone = TimeZone.current) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.timeZone = timezone
        let stringDate = formatter.string(from: date)
        guard !stringDate.isEmpty else { return nil }
        
        self = stringDate
    }
    
    @available(iOS 8.0, *)
    public func reformattingDate(formattedWith sourceFormat: String,
                                 `in` sourceTimezone: TimeZone = TimeZone.current,
                                 toStringFormattedWith targetFormat: String,
                                 `in` targetTimezone: TimeZone = TimeZone.current) -> String? {
        if let date = Date(from: self, formattedWith: sourceFormat, in: sourceTimezone) {
            return String(from: date, formattedWith: targetFormat, in: targetTimezone)
        }
        return nil
    }
    
    @available(iOS 8.0, *)
    public mutating func reformatDate(formattedWith sourceFormat: String,
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
