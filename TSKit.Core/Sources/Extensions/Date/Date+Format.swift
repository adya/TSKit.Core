/// TSTOOLS:  Description... 9/19/16.
import Foundation

@available(iOS 8.0, *)
public extension Date {
    
    @available(iOS 8.0, *)
    public func toString(withFormat targetFormat : String,
                         andTimezone timezone : TimeZone = TimeZone.current) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = targetFormat
        formatter.timeZone = timezone
        return formatter.string(from: self)
    }
    
    @available(iOS 8.0, *)
    public static func fromString(_ dateString : String,
                                  withFormat targetFormat: String,
                                  andTimezone timezone : TimeZone = TimeZone.current) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = targetFormat
        formatter.timeZone = timezone
        return formatter.date(from: dateString)
    }
    
    @available(iOS 8.0, *)
    public func date(with dateComponents: [Calendar.Component]) -> Date {
        let comps = Calendar.current.dateComponents(Set<Calendar.Component>(dateComponents), from: self)
        return Calendar.current.date(from: comps)!
    }
}
