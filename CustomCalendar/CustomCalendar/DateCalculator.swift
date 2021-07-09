//
//  DateCalculator.swift
//  CustomCalendar
//
//  Created by JunHee Jo on 2021/07/05.
//

import UIKit

class DateCalculator {
    private let calendar: Calendar = Calendar.current
    
    public func extractYearComponent(date: Date) -> DateComponents {
        return calendar.dateComponents([.year], from: date)
    }
    
    public func extractMonthComponent(date: Date) -> DateComponents {
        return calendar.dateComponents([.month], from: date)
    }
}
