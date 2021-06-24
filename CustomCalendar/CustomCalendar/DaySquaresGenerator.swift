//
//  MonthCalendarGenerator.swift
//  CustomCalendar
//
//  Created by JunHee Jo on 2021/06/23.
//

import Foundation
import UIKit

class DaySquaresGenerator {
    private let maxSquareCount: Int = 42
    private var totalDaySquares: [String] = []
    private var count: Int = 1
    
    public func create(selectedDate: Date) -> [String] {
        let daysInMonth: Int = CalendarHelper().daysInMonth(date: selectedDate)
        let firstDayOfMonth: Date = CalendarHelper().firstOfMonth(date: selectedDate)
        let startingSpaces: Int = CalendarHelper().weekDay(date: firstDayOfMonth)

        while count <= maxSquareCount {
            if (count <= startingSpaces) || (count - startingSpaces > daysInMonth) {
                totalDaySquares.append("")
            } else {
                totalDaySquares.append(String(count - startingSpaces))
            }
            
            count += 1
        }
        
        return totalDaySquares
    }
}
