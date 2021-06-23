//
//  MonthCalendarGenerator.swift
//  CustomCalendar
//
//  Created by JunHee Jo on 2021/06/23.
//

import Foundation
import UIKit

class MonthCalendarGenerator {
    private var selectedDate = Date()
    var daysInMonth: Int {
        CalendarHelper().daysInMonth(date: selectedDate)
    }
    var firstDayOfMonth: Date {
        CalendarHelper().firstOfMonth(date: selectedDate)
    }
    var startingSpaces: Int {
        CalendarHelper().weekDay(date: firstDayOfMonth)
    }
    
    let maxSquareCount: Int = 42
    var count: Int = 1
    
    func createMonthCalendar( totalSquares: inout [String]) {
        while count <= maxSquareCount {
            if (count <= startingSpaces) || (count - startingSpaces > daysInMonth) {
                totalSquares.append("")
            } else {
                totalSquares.append(String(count - startingSpaces))
            }
            
            count += 1
        }
    }
}
