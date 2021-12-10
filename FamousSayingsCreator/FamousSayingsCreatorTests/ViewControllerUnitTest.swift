//
//  ViewControllerUnitTest.swift
//  FamousSayingsCreatorTests
//
//  Created by JunHeeJo on 12/10/21.
//

import XCTest
@testable import FamousSayingsCreator

class ViewControllerUnitTest: XCTestCase {
    var sut: ViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ViewController()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_tapQuoteGeneratorButton_shouldGenerateQuotes() {
        // given
        
        // when
        
        //then
    }
}
