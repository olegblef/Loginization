//
//  TestsSupportTest.swift
//  TestLoginizationTests
//
//  Created by Oleh Blef on 6/20/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import XCTest

@testable import TestLoginization

class TestSupportTests: XCTestCase {
    
    func testGenerateSharedInfoSuccess() {
        let support = TestsSupport()
        let result = support.generateSharedInfo(2)
        let accounts = [SharedInfo(email: "test", password: "test"),
                        SharedInfo(email: "test1", password: "test1"),
                        SharedInfo(email: "test2", password: "test2")]
        
        XCTAssertEqual(result, accounts)
    }
    
    func testGenerateSharedInfoZeroSuccess() {
        let support = TestsSupport()
        let result = support.generateSharedInfo(0)
        let account = SharedInfo(email: "test", password: "test")
        
        XCTAssertEqual(result, [account])
    }
    
    func testStoreFeelingSuccess() {
        let support = TestsSupport()
        let accounts = [SharedInfo(email: "test", password: "test"),
                        SharedInfo(email: "test1", password: "test1"),
                        SharedInfo(email: "test2", password: "test2")]
        let store = Store()
        support.storeFeeling(store: store, accounts: accounts)
        
        XCTAssertEqual(store.get(), accounts)
    }
}
