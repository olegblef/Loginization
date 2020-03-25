//
//  LoginPresentationModelTests.swift
//  TestLoginizationTests
//
//  Created by Oleh Blef on 6/23/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import XCTest
import ReactiveSwift

@testable import TestLoginization

class LoginPresentationModelTests: XCTestCase {
    
    let support = TestsSupport()

    override func setUp() {
        let startPresentationModel = StartPresentationModelMock()
        XCTAssertNil(startPresentationModel.event)
    }
    
    func testOnVerifySuccess() {
        let loginPresentationModel = LoginPresentationModelMock()
        guard let account = self.support.generateSharedInfo(0).first else { return }
        loginPresentationModel.inputingEmail = account.email
        loginPresentationModel.inputingPassword = account.password
        loginPresentationModel.onVerify()
        XCTAssertTrue(loginPresentationModel.result)
    }
    
    func testOnVerifyFalse() {
        let loginPresentationModel = LoginPresentationModelMock()
        let account = self.support.getValidAccount()
        loginPresentationModel.inputingEmail = account.email
        loginPresentationModel.inputingPassword = account.password
        loginPresentationModel.onVerify()
        XCTAssertFalse(loginPresentationModel.result)
    }
    
    func testGoAccountSuccess() {
        let loginPresentationModel = LoginPresentationModelMock()
        loginPresentationModel.doDoneVerify(true)
        loginPresentationModel.goAccount()
        XCTAssertTrue(loginPresentationModel.event == .accaunt)
    }
    
    func testGoAccountFalse() {
        let loginPresentationModel = LoginPresentationModelMock()
        loginPresentationModel.doDoneVerify(false)
        loginPresentationModel.goAccount()
        XCTAssertFalse(loginPresentationModel.event == .accaunt)
    }
    
    func testGoBack() {
        let loginPresentationModel = LoginPresentationModelMock()
        loginPresentationModel.goBack()
        XCTAssertTrue(loginPresentationModel.event == .back)
    }
}
