//
//  AutoLoginServiceTests.swift
//  TestLoginizationTests
//
//  Created by Oleh Blef on 6/19/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import XCTest

@testable import TestLoginization

class AutoLoginServiceTests: XCTestCase {
    
    // MARK: - Private properties
    
    let support = TestsSupport()
    
    // MARK: - TestsMethods
    
    func testGetSuccess() {
        let info = self.support.generateSharedInfo(0)
        let login = AutoLoginService(info[0])
        
        XCTAssertEqual(login.get(), info[0])
    }

    
    func testUpdateEmailSuccess() {
        let info = self.support.getValidAccount()
        let login = AutoLoginService(info)
        let newEmail = self.support.getValidEmail()
        
        login.updateEmail(newEmail)
        
        XCTAssertEqual(newEmail, login.get()?.email)
    }
    
    func testUpdateEmailFalse() {
        let info = self.support.getValidAccount()
        let login = AutoLoginService(info)
        let newEmail = self.support.getValidEmail() + "%*"
        
        login.updateEmail(newEmail)
        
        XCTAssertEqual(login.get()?.email, info.email)
    }
    
    func testUpdatePasswordSuccess() {
        let info = self.support.getValidAccount()
        let login = AutoLoginService(info)
        let newPassword = self.support.getValidPassword()
        
        login.updatePassword(newPassword)
        
        XCTAssertEqual(newPassword, login.get()?.password)
    }
    
    func testUpdatePasswordFalse() {
        let info = self.support.getValidAccount()
        let login = AutoLoginService(info)
        let newPassword = self.support.getValidPassword() + "$%&^"
    
        login.updatePassword(newPassword)
        
        XCTAssertEqual(info.password, login.get()?.password)
    }
}
