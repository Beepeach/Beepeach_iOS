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
    
    func test_method_shouldReturnCalendarMonthComponent() {
        let date: Date = Date(timeIntervalSinceReferenceDate: 0)
        
        let monthComponent: DateComponents = sut.extractMonthComponent(date: date)
        
        XCTAssertEqual(monthComponent.month, 1)
    }
}
