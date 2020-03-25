//
//  TestsSupport.swift
//  TestLoginization
//
//  Created by Oleh Blef on 6/20/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import Foundation

class TestsSupport {
    
    public func generateSharedInfo(_ count: UInt) -> [SharedInfo] {
        var result = [SharedInfo(email: "test", password: "test")]
        if count > 0 {
            for i in 1...count {
                let text: String = "test" + String(i)
                result.append(SharedInfo(email: text, password: text))
            }
        }
        
        return result
    }
    
    public func storeFeeling(store: Store, accounts: [SharedInfo]) {
        accounts.forEach {
            store.add($0)
        }
    }
    
    public func getValidEmail() -> String {
        return "valid@gmail.com"
    }
    
    public func getValidPassword() -> String {
        return "valid1234"
    }
    
    public func getValidAccount() -> SharedInfo {
        return SharedInfo(email: "valid@ukr.net", password: "valid4321")
    }
}
