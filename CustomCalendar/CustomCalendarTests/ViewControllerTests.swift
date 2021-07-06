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
        sut = storyboard.instantiateViewController(identifier: "ViewController")
        
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_action_whenTapPreviousMonth_shouldChangeSelectedDate() {
 
        
    }
    
    func test_collectionViewItem_whenDidSelectItemAt_shouldReturnSelectedDate() {
        // Delegate는 어떻게 테스트를 해야할까???
        sut.
        
    }
    
}

