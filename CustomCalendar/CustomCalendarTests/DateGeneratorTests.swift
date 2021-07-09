//
//  DateGeneratorTests.swift
//  CustomCalendarTests
//
//  Created by JunHee Jo on 2021/07/05.
//

import XCTest
@testable import CustomCalendar

class DateGeneratorTests: XCTestCase {
    var sut: DateGenerator!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = DateGenerator()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_whenGivenComponents_shouldCreateDate() {
        let year: Int = Int.random(in: 2000...2100)
        let month: Int = Int.random(in: 1...12)
        let day: Int = Int.random(in: 1...31)
        let components: DateComponents = DateComponents(year: year, month: month, day: day)
        let expectedDate: Date = Calendar.current.date(from: components)!
        
        let date: Date = sut.createStartOfDay(year: year, month: month, day: day)
        
        XCTAssertEqual(expectedDate, date)
    }
}
