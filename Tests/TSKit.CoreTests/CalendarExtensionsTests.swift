import XCTest
@testable import TSKit_Core

class CalendarExtensionsTests: XCTestCase {
    
    let calendarStartingOnMonday = transform(Calendar.current) { $0.firstWeekday = 2 }
}

// MARK: - Months
extension CalendarExtensionsTests {
    
    @available(iOS 10.0, *)
    @available(macOS 10.12, *)
    func testNextMonth() {
        let today = Date(from: "2022-01-31T00:00:00+02:00",
                         formattedWith: "YYYY-MM-dd'T'HH:mm:ssZZZZZ")!
        let nextMonthFirstDay = Date(from: "2022-02-01T00:00:00+02:00",
                                     formattedWith: "YYYY-MM-dd'T'HH:mm:ssZZZZZ")!
        let nextMonthLastDay = Date(from: "2022-02-28T23:59:59+02:00",
                                    formattedWith: "YYYY-MM-dd'T'HH:mm:ssZZZZZ")!
        let nextMonth = Calendar.current.nextMonth(for: today)!

        XCTAssertEqual(nextMonth.start, nextMonthFirstDay, "Next month should start on Feb 1")
        XCTAssertEqual(nextMonth.end, nextMonthLastDay, "Next month should end on Feb 28")
    }
    
    @available(iOS 10.0, *)
    @available(macOS 10.12, *)
    func testCurrentMonth() {
        let today = Date(from: "2022-01-31T00:00:00+02:00",
                         formattedWith: "YYYY-MM-dd'T'HH:mm:ssZZZZZ")!
        let currentMonthFirstDay = Date(from: "2022-01-01T00:00:00+02:00",
                                     formattedWith: "YYYY-MM-dd'T'HH:mm:ssZZZZZ")!
        let currentMonthLastDay = Date(from: "2022-01-31T23:59:59+02:00",
                                    formattedWith: "YYYY-MM-dd'T'HH:mm:ssZZZZZ")!
        let currentMonth = Calendar.current.currentMonth(for: today)!
        
        XCTAssertEqual(currentMonth.start, currentMonthFirstDay, "Current month should start on Jan 1")
        XCTAssertEqual(currentMonth.end, currentMonthLastDay, "Current month should end on Jan 31")
    }
    
    @available(iOS 10.0, *)
    @available(macOS 10.12, *)
    func testPreviousMonth() {
        let today = Date(from: "2022-03-15T00:00:00+02:00",
                         formattedWith: "YYYY-MM-dd'T'HH:mm:ssZZZZZ")!
        let previousMonthFirstDay = Date(from: "2022-02-01T00:00:00+02:00",
                                     formattedWith: "YYYY-MM-dd'T'HH:mm:ssZZZZZ")!
        let previousMonthLastDay = Date(from: "2022-02-28T23:59:59+02:00",
                                    formattedWith: "YYYY-MM-dd'T'HH:mm:ssZZZZZ")!
        let previousMonth = Calendar.current.previousMonth(for: today)!
        
        XCTAssertEqual(previousMonth.start, previousMonthFirstDay, "Previous month should start on Feb 1")
        XCTAssertEqual(previousMonth.end, previousMonthLastDay, "Previous month should end on Feb 28")
    }
}

// MARK: - Weeks
extension CalendarExtensionsTests {

    @available(iOS 10.0, *)
    @available(macOS 10.12, *)
    func testNextWeek() {
        let today = Date(from: "2022-01-31T00:00:00+02:00",
                         formattedWith: "YYYY-MM-dd'T'HH:mm:ssZZZZZ")!
        let nextWeekFirstDay = Date(from: "2022-02-07T00:00:00+02:00",
                                     formattedWith: "YYYY-MM-dd'T'HH:mm:ssZZZZZ")!
        let nextWeekLastDay = Date(from: "2022-02-13T23:59:59+02:00",
                                    formattedWith: "YYYY-MM-dd'T'HH:mm:ssZZZZZ")!
        let nextWeek = calendarStartingOnMonday.nextWeek(for: today)!
        
        XCTAssertEqual(nextWeek.start, nextWeekFirstDay, "Next week should start on Feb 7")
        XCTAssertEqual(nextWeek.end, nextWeekLastDay, "Next week should end on Feb 13")
    }
    
    @available(iOS 10.0, *)
    @available(macOS 10.12, *)
    func testCurrentWeek() {
        let today = Date(from: "2022-01-31T00:00:00+02:00",
                         formattedWith: "YYYY-MM-dd'T'HH:mm:ssZZZZZ")!
        let currentWeekFirstDay = Date(from: "2022-01-31T00:00:00+02:00",
                                     formattedWith: "YYYY-MM-dd'T'HH:mm:ssZZZZZ")!
        let currentWeekLastDay = Date(from: "2022-02-06T23:59:59+02:00",
                                    formattedWith: "YYYY-MM-dd'T'HH:mm:ssZZZZZ")!
        let currentWeek = calendarStartingOnMonday.currentWeek(for: today)!
        
        XCTAssertEqual(currentWeek.start, currentWeekFirstDay, "Current week should start on Jan 31")
        XCTAssertEqual(currentWeek.end, currentWeekLastDay, "Current week should end on Feb 6")
    }
    
    @available(iOS 10.0, *)
    @available(macOS 10.12, *)
    func testPreviousWeek() {
        let today = Date(from: "2022-01-31T00:00:00+02:00",
                         formattedWith: "YYYY-MM-dd'T'HH:mm:ssZZZZZ")!
        let previousWeekFirstDay = Date(from: "2022-01-24T00:00:00+02:00",
                                     formattedWith: "YYYY-MM-dd'T'HH:mm:ssZZZZZ")!
        let previousWeekLastDay = Date(from: "2022-01-30T23:59:59+02:00",
                                    formattedWith: "YYYY-MM-dd'T'HH:mm:ssZZZZZ")!
        let previousWeek = calendarStartingOnMonday.previousWeek(for: today)!
        
        XCTAssertEqual(previousWeek.start, previousWeekFirstDay, "Previous week should start on Jan 24")
        XCTAssertEqual(previousWeek.end, previousWeekLastDay, "Previous week should end on Jan 30")
    }
}

// MARK: Days
extension CalendarExtensionsTests {
    
    @available(iOS 10.0, *)
    @available(macOS 10.12, *)
    func testDay() {
        let today = Date(from: "2022-01-31T00:00:00+02:00",
                         formattedWith: "YYYY-MM-dd'T'HH:mm:ssZZZZZ")!
        let dayStart = Date(from: "2022-01-31T00:00:00+02:00",
                                     formattedWith: "YYYY-MM-dd'T'HH:mm:ssZZZZZ")!
        let dayEnd = Date(from: "2022-01-31T23:59:59+02:00",
                                    formattedWith: "YYYY-MM-dd'T'HH:mm:ssZZZZZ")!
        let day = calendarStartingOnMonday.day(for: today)!
        
        XCTAssertEqual(day.start, dayStart, "Day should start at 00:00:00 on Jan 31")
        XCTAssertEqual(day.end, dayEnd, "Day should end at 23:59:59 on Jan 31")
    }
    
}
