//
//  date+extension.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 12/09/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import Foundation

extension Date {
    func getSimpleFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd"
        return dateFormatter.string(from: self)
    }
    
    func getReadableDateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy"
        return dateFormatter.string(from: self)
    }
    
    func getReadableFullFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd '|' hh:mm a"
        return dateFormatter.string(from: self)
    }
    
    func getTimeFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: self)
    }
    
    func timeStampFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: self)
    }
    
    func getCurrentTimeStampWOMiliseconds() -> String {
        let objDateformat: DateFormatter = DateFormatter()
        objDateformat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let strTime: String = objDateformat.string(from: self)
        guard let objUTCDate: Date = objDateformat.date(from: strTime) else {
            return ""
        }
        let milliseconds: Int64 = Int64(objUTCDate.timeIntervalSince1970)
        let strTimeStamp: String = "\(milliseconds)"
        return strTimeStamp
    }
}

extension Date {
    func isEqual(to date: Date, toGranularity component: Calendar.Component, in calendar: Calendar = .current) -> Bool {
        calendar.isDate(self, equalTo: date, toGranularity: component)
    }

    func isInSameYear (date: Date) -> Bool { isEqual(to: date, toGranularity: .year) }
    func isInSameMonth(date: Date) -> Bool { isEqual(to: date, toGranularity: .month) }
    func isInSameDay  (date: Date) -> Bool { isEqual(to: date, toGranularity: .day) }
    func isInSameWeek (date: Date) -> Bool { isEqual(to: date, toGranularity: .weekOfYear) }
    
    var isInLastWeek: Bool {
        let calendar = Calendar.current
        let weekOfYearToday = calendar.component(.weekOfYear, from: Date())
        let weekOfYearDate = calendar.component(.weekOfYear, from: self)
        return (weekOfYearToday > 0 && weekOfYearToday == weekOfYearDate + 1)
    }

    var isInThisYear: Bool { isInSameYear(date: Date()) }
    var isInThisMonth: Bool { isInSameMonth(date: Date()) }
    var isInThisWeek: Bool { isInSameWeek(date: Date()) }

    var isInYesterday: Bool { Calendar.current.isDateInYesterday(self) }
    var isInToday: Bool { Calendar.current.isDateInToday(self) }
    var isInTomorrow: Bool { Calendar.current.isDateInTomorrow(self) }

    var isInTheFuture: Bool { self > Date() }
    var isInThePast: Bool { self < Date() }
    
    func getDateByChangingSeconds(add: Bool, number: Int) -> Date {
        let value = add ? number : -number
        let nextDate = Calendar.current.date(byAdding: .second, value: value, to: self)
        return nextDate ?? self
    }
    
    func getDateByChangingHours(add: Bool, number: Int) -> Date {
        let value = add ? number : -number
        let nextDate = Calendar.current.date(byAdding: .hour, value: value, to: self)
        return nextDate ?? self
    }
    
    func getDateByChangingDays(add: Bool, number: Int) -> Date {
        let value = add ? number : -number
        let nextDate = Calendar.current.date(byAdding: .day, value: value, to: self)
        return nextDate ?? self
    }
}
