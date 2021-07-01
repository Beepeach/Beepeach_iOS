//
//  CalendarHelper.swift
//  CustomCalendar
//
//  Created by JunHee Jo on 2021/06/23.
//

import Foundation
import UIKit

class CalendarHelper {
    // MARK: Properties
    private let calendar: Calendar = Calendar.current
    
    // MARK: Interface
    // 2021.06.23 -> 2021.07.23
    public func plusMonth(date: Date) -> Date {
        guard let date = calendar.date(byAdding: .month, value: 1, to: date) else {
            return Date()
        }
        
        return date
    }
    
    // 2021.06.23 -> 2021.05.23
    public func minusMonth(date: Date) -> Date {
        guard let date = calendar.date(byAdding: .month, value: -1, to: date) else {
            return Date()
        }
        
        return date
    }
    
    // 2021.06.23 -> 06월
    public func monthString(date: Date) -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월"
        dateFormatter.locale = Locale(identifier: "ko_kr")
        return dateFormatter.string(from: date)
    }
    
    // 2021.06.23 -> 2021년
    public func yearString(date: Date) -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년"
        dateFormatter.locale = Locale(identifier: "ko_kr")
        return dateFormatter.string(from: date)
    }
    
    // 2021.06.23 -> 30
    public func daysInMonth(date: Date) -> Int {
        let range = calendar.range(of: .day, in: .month, for: date)
        
        return range?.count ?? 30
    }
    
    // 2021.06.23 -> 23
    public func dayOfMonth(date: Date) -> Int {
        let components = calendar.dateComponents([.day], from: date)
        return components.day ?? 0
    }
    
    public func firstOfMonth(date: Date) -> Date {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components) ?? Date()
    }
    
    public func weekDay(date: Date) -> Int {
        let components = calendar.dateComponents([.weekday], from: date)
        
        guard let weekDay = components.weekday else { return 0 }

        return weekDay - 1
    }
    
    public func getCurrentCalendar() -> Calendar {
        return self.calendar
    }
}

