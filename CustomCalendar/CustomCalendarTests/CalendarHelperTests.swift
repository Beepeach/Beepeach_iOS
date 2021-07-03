//
//  CalendarHelperTests.swift
//  CustomCalendarTests
//
//  Created by JunHee Jo on 2021/06/29.
//

import XCTest
@testable import CustomCalendar

class CalendarHelperTests: XCTestCase {
    
    var sut: CalendarHelper!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CalendarHelper()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_calendar_whenAlways_shouldCurrentCalendar() {
        let userCalendar = sut.getCurrentCalendar()

        XCTAssertEqual(Calendar.current, userCalendar)
    }
    
    func test_plusMonth_whenIsCalled_shouldPlusOneMonth() {
        let calendar: Calendar = Calendar.current
        let beforeDate: Date = Date()
        let beforeDateMonth: Int = calendar.component(.month, from: beforeDate)
        
        let afterDate: Date = sut.plusMonth(date: beforeDate)
        let afterDateMonth: Int = calendar.component(.month, from: afterDate)
        
        XCTAssertEqual(beforeDateMonth + 1, afterDateMonth)
    }
    
    func test_minusMonth_whenIsCalled_shouldMinusOneMonth() {
        let calendar: Calendar = Calendar.current
        let beforeDate: Date = Date()
        let beforeDateMonth: Int = calendar.component(.month, from: beforeDate)
        
        let afterDate: Date = sut.minusMonth(date: beforeDate)
        let afterDateMonth: Int = calendar.component(.month, from: afterDate)
        
        XCTAssertEqual(beforeDateMonth - 1, afterDateMonth)
    }
    
    func test_when
}
