//
//  ValidationTests.swift
//  TestLoginizationTests
//
//  Created by Oleh Blef on 6/19/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import Foundation
import XCTest

@testable import TestLoginization

class ValidationTests: XCTestCase {
    
    func testIsValidEmailFalse() {
        let emails = ["d@u.n",
                      "славаУкраїні@ukr.net",
                      "aaa.aaa.aaa",
                      "aa%@kj*.gjk"]
        
        emails.forEach {
            XCTAssertFalse(isValidEmail(text: $0))
        }
    }

    func testIsValidEmailSuccess() {
        let rightEmail = "aaa@aaa.aaa"
        
        XCTAssertTrue(isValidEmail(text: rightEmail))
    }
    
    func testIsValidPasswordFalse() {
        let passwords = ["aaaaaaaa",
                         "11111111",
                         "aaaa1111&",
                         "привіт1111"]
        
        passwords.forEach {
            XCTAssertFalse(isValidPassword(text: $0))
        }
    }
    
    func testIsValidPasswordSuccess() {
        let rightPassword = "aaaa1111"
        
        XCTAssertTrue(isValidPassword(text: rightPassword))
    }
}
