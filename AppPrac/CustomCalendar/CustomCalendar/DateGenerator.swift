//
//  DateGenerator.swift
//  CustomCalendar
//
//  Created by JunHee Jo on 2021/07/05.
//

import UIKit

// 이번에는 struct로 만들어보았다.
struct DateGenerator {
    private var calendar: Calendar  {
        var calendar: Calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        
        return calendar
    }
    
    public func createStartOfDay(year: Int, month: Int, day: Int) -> Date {
        var components: DateComponents = DateComponents()
        components.timeZone = TimeZone.current
        components.year = year
        components.month = month
        components.day = day
     
        let date: Date = calendar.date(from: components) ?? Date()
        let startOfDay: Date = calendar.startOfDay(for: date)
        
        return startOfDay
    }
}
