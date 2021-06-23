//
//  CalendarHelper.swift
//  CustomCalendar
//
//  Created by JunHee Jo on 2021/06/23.
//

import Foundation
import UIKit

class CalendarHelper {
    let calendar: Calendar = Calendar.current
    
    func plusMonth(date: Date) -> Date {
        guard let date = calendar.date(byAdding: .month, value: 1, to: date) else {
            return Date()
        }
        
        return date
    }
    
    func minusMonth(date: Date) -> Date {
        guard let date = calendar.date(byAdding: .month, value: -1, to: date) else {
            return Date()
        }
        
        return date
    }
    
    func monthString(date: Date) -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        dateFormatter.locale = Locale(identifier: "ko_kr")
        return dateFormatter.string(from: date)
    }
    
    func yearString(date: Date) -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년"
        dateFormatter.locale = Locale(identifier: "ko_kr")
        return dateFormatter.string(from: date)
    }
    
    func daysInMonth(date: Date) -> Int {
        let range = calendar.range(of: .day, in: .month, for: date)
        
        return range?.count ?? 30
    }
    
    func dayOfMonth(date: Date) -> Int {
        let components = calendar.dateComponents([.day], from: date)
        return components.day ?? 0
    }
    
    func firstOfMonth(date: Date) -> Date {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components) ?? Date()
    }
    
    func weekDay(date: Date) -> Int {
        let components = calendar.dateComponents([.weekday], from: date)
        
        guard let weekDay = components.weekday else { return 0 }

        return weekDay - 1
    }
}

