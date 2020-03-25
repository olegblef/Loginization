//
//  AutoLoginService.swift
//  TestLoginization
//
//  Created by Oleh Blef on 6/14/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import Foundation

class AutoLoginService {
    
    // MARK: - Private properties
    
    private var autoLogin: SharedInfo
    
    private var email: String? {
        get {
            return self.autoLogin.email
        }
        set {
            self.autoLogin.email = newValue ?? ""
        }
    }
    
    private var password: String? {
        get {
            return self.autoLogin.password
        }
        set {
            self.autoLogin.password = newValue ?? ""
        }
    }
    
    // MARK: - Initializations and Deallocations
    
    init(_ autoLogin: SharedInfo = SharedInfo(email: "", password: "")) {
        self.autoLogin = autoLogin
    }
    
    // MARK: - Public methods
    
    public func get() -> SharedInfo? {
        return self.autoLogin
    }
    
    public func updateEmail(_ email: String) {
        if isValidEmail(text: email) {
            self.email = email
        }
    }
    
    public func updatePassword(_ password: String) {
        if isValidPassword(text: password) {
            self.password = password
        }
    }
}
