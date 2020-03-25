//
//  SharedInfo.swift
//  TestLoginization
//
//  Created by Oleh Blef on 6/2/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import Foundation

class SharedInfo: Equatable {
    
    // MARK: - Internal properties
    
    var email: String = ""
    var password: String = ""
    
    // MARK: - Initializations and Deallocations
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    // MARK: - Static methods
    
    static func == (lhs: SharedInfo, rhs: SharedInfo) -> Bool {
        if lhs.email == rhs.email && lhs.password == rhs.password {
            return true
        } else {
            return false
        }
    }
}
