//
//  ViewControllerTests.swift
//  CustomCalendarTests
//
//  Created by JunHee Jo on 2021/07/05.
//

import XCTest
@testable import CustomCalendar

class ViewControllerTests: XCTestCase {
    var sut: ViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        sut = (storyboard.instantiateViewController(identifier: "ViewController") as! ViewController)
        
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    private func givenBeforeDate() -> Date {
        let beforeDate: Date = sut.getSelectedDate()
        
        return beforeDate
    }
    
    private func givenAfterDate() -> Date {
        let afterDate: Date = sut.getSelectedDate()
        
        return afterDate
    }
    
    func testPreviousMonth_whenTap_shouldChangeSelectedDate() {
        let beforeDate = givenBeforeDate()
        
        sut.previousMonth(sut as Any)
        let afterDate = givenAfterDate()
        
        XCTAssertNotEqual(beforeDate, afterDate)
    }
    
    func testNextMonth_whenTap_shouldChangeSelectedDate() {
        let beforeDate = givenBeforeDate()
        
        sut.nextMonth(sut as Any)
        let afterDate = givenAfterDate()
        
        XCTAssertNotEqual(beforeDate, afterDate)
    }
    
    func testCollectionView_whenViewDidLoad_shouldSetDelegate() {
        sut.viewDidLoad()
        
        XCTAssertTrue(sut.collectionView.delegate === sut)
    }
    
    private func givenSelectedDateAt20210601() -> Date {
        let date: Date = Calendar.current.date(from: DateComponents(year: 2021, month: 6, day: 1))!
        
        return date
    }
    
    func test_DateCollectionViewItem_whenTapWithNoDate_shouldNotSelected() {
        let date: Date = givenSelectedDateAt20210601()
        sut.setSelectedDate(date: date)
        
        let indexPath: IndexPath = IndexPath(item: 0, section: 0)
        
        XCTAssertFalse(sut.collectionView.delegate!.collectionView!(sut.collectionView, shouldSelectItemAt: indexPath))
    }
    
    func test_DateCollectionViewItem_whenTapWithDate_shouldSelected() {
        let date: Date = givenSelectedDateAt20210601()
        sut.setSelectedDate(date: date)
        
        let indexPath: IndexPath = IndexPath(item: 5, section: 0)
        
        XCTAssertTrue(sut.collectionView.delegate!.collectionView!(sut.collectionView, shouldSelectItemAt: indexPath))
    }
    
    
    func test_collectionViewItem_whenCreate_shouldAssignCollectDate() {
        // Delegate는 어떻게 테스트를 해야할까??? 이렇게 하나만 테스트해도 괜찮은걸까?
        let date: Date = givenSelectedDateAt20210601()
        sut.setSelectedDate(date: date)
        
        let indexPath: IndexPath = IndexPath(item: 2, section: 0)
        
        let cell = sut.collectionView.dataSource?.collectionView(sut.collectionView, cellForItemAt: indexPath) as! CalendarCollectionViewCell
     
        XCTAssertEqual(date, cell.getDate())
    }
    
}

