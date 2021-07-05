//
//  DateGenerator.swift
//  CustomCalendar
//
//  Created by JunHee Jo on 2021/07/05.
//

import UIKit

// 이번에는 struct로 만들어보았다.
struct DateGenerator {
    private let calendar: Calendar = Calendar.current
    
    public func create(year: Int, month: Int, day: Int) -> Date {
        let components: DateComponents = DateComponents(year: year, month: month, day: day)
        
        let date: Date = calendar.date(from: components) ?? Date()
        
        return date
    }
}
