//
//  StartPresentationModelTests.swift
//  TestLoginizationTests
//
//  Created by Oleh Blef on 6/23/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import XCTest
import ReactiveSwift

@testable import TestLoginization

class StartPresentationModelTests: XCTestCase {

    override func setUp() {
        let startPresentationModel = StartPresentationModelMock()
        XCTAssertNil(startPresentationModel.event)
    }

    func testOnLogin() {
        let startPresentationModel = StartPresentationModel()
//        startPresentationModel.onLogin()
        
        XCTAssertTrue(startPresentationModel.event == .login)
    }
    
    func testOnRegistration() {
        let startPresentationModel = StartPresentationModelMock()
        startPresentationModel.onRegistration()
        XCTAssertTrue(startPresentationModel.event == .registration)
    }
}
