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
}
