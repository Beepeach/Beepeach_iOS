//
//  DateCalculatorTests.swift
//  CustomCalendarTests
//
//  Created by JunHee Jo on 2021/07/05.
//

import XCTest
@testable import CustomCalendar

class DateCalculatorTests: XCTestCase {
    
    var sut: DateCalculator!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = DateCalculator()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    private func givenReferenceDate() -> Date {
        let date: Date = Date(timeIntervalSinceReferenceDate: 0)
        
        return date
    }
    
    func test_method_shouldReturnCalendarYearComponent() {
        let date = givenReferenceDate()
        
        let yearComponent: DateComponents = sut.extractYearComponent(date: date)
        
        XCTAssertEqual(yearComponent.year, 2001)
    }
    
    func test_method_shouldReturnCalendarMonthComponent() {
        let date: Date = givenReferenceDate()
        
        let monthComponent: DateComponents = sut.extractMonthComponent(date: date)
        
        XCTAssertEqual(monthComponent.month, 1)
    }
}
