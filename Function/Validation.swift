//
//  ViewController+Extension.swift
//  TestLoginization
//
//  Created by Oleh Blef on 5/25/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import UIKit

    public func isValidEmail(text: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluate(with: text)
    }
    
    public func isValidPassword(text: String) -> Bool {
        let passwordRegex = "^(?=.*[a-zA-Z\\u0621-\\u064A])(?=.*[0-9\\u0660-\\u0669])[a-zA-Za-z\\u0621-\\u064A0-9\\u0660-\\u0669]{8,}$"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        
        return passwordTest.evaluate(with: text)
    }
