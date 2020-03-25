//
//  StoreTests.swift
//  TestLoginizationTests
//
//  Created by Oleh Blef on 6/19/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import XCTest

@testable import TestLoginization

class StoreTests: XCTestCase {
    
    // MARK: - Private properties
    
    private let support = TestsSupport()
    
    // MARK - Tests methods
    
    func testAdd() {
        let store = Store()
        let accounts = support.generateSharedInfo(1)
        self.support.storeFeeling(store: store, accounts: accounts)
        XCTAssertTrue(store.get().count == 2)
    }

    func testDeleteSuccess() {
        let store = Store()
        var accounts = support.generateSharedInfo(3)
        self.support.storeFeeling(store: store, accounts: accounts)
        store.delete(accounts[0])
        accounts.remove(at: 0)
        XCTAssertEqual(store.get(), accounts)
    }

    func testDeleteFail() {
        let store = Store()
        let accounts = self.support.generateSharedInfo(3)
        let testFourString = "test4"
        self.support.storeFeeling(store: store, accounts: accounts)
        store.delete(SharedInfo(email: testFourString, password: testFourString))
        XCTAssertEqual(store.get(), accounts)
    }

    func testUpdateEmailSuccess() {
        let store = Store()
        let accounts = self.support.generateSharedInfo(2)
        let validEmail = self.support.getValidEmail()
        self.support.storeFeeling(store: store, accounts: accounts)
        store.updateEmail(accounts[0], newEmail: validEmail)
        accounts[0].email = validEmail
        XCTAssertEqual(store.get(), accounts)
    }

    func testUpdateEmailFail() {
        let store = Store()
        let accounts = self.support.generateSharedInfo(2)
        let invalidEmail = self.support.getValidEmail() + "%^&*"
        self.support.storeFeeling(store: store, accounts: accounts)
        store.updateEmail(accounts[0], newEmail: invalidEmail)
        XCTAssertEqual(store.get(), accounts)
    }

    func testUpdatePasswordSuccess() {
        let store = Store()
        let accounts = self.support.generateSharedInfo(2)
        let validPass = self.support.getValidPassword()
        self.support.storeFeeling(store: store, accounts: accounts)
        store.updatePassword(accounts[0], newPassword: validPass)
        accounts[0].password = validPass
        XCTAssertEqual(store.get(), accounts)
    }

    func testUpdatePasswordFail() {
        let store = Store()
        let accounts = self.support.generateSharedInfo(1)
        let invalidPass = ""
        self.support.storeFeeling(store: store, accounts: accounts)
        store.updatePassword(accounts[0], newPassword: invalidPass)
        XCTAssertEqual(store.get(), accounts)
    }

    func testGet() {
        let store = Store()
        let accounts = self.support.generateSharedInfo(3)
        self.support.storeFeeling(store: store, accounts: accounts)
        XCTAssertEqual(store.get(), accounts)
    }

    func testFindSimilarEmailSuccess() {
        let store = Store()
        let accounts = self.support.generateSharedInfo(3)
        self.support.storeFeeling(store: store, accounts: accounts)
        XCTAssertTrue(store.findSimilarEmail(email: accounts[0].email))
    }

    func testFindSimilarEmailFail() {
        let store = Store()
        let accounts = self.support.generateSharedInfo(3)
        self.support.storeFeeling(store: store, accounts: accounts)
        XCTAssertFalse(store.findSimilarEmail(email: accounts[0].email+".net"))
    }
}
