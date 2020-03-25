//
//  File.swift
//  TestLoginization
//
//  Created by Oleh Blef on 5/27/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import Foundation

struct LoginViewData: BaseViewData {

    let email: String?
    let password: String?
    let onUpdateEmail: ((String) -> ())?
    let onUpdatePassword: ((String) -> ())?
    let verifyAccaunt: (() -> ())?
    let onAccount: (() -> ())?
    let onBack: (() -> ())?
    let doneVerify: Bool
    
    static var initial: LoginViewData {
        return LoginViewData(email: nil,
                             password: nil,
                             onUpdateEmail: nil,
                             onUpdatePassword: nil,
                             verifyAccaunt: nil,
                             onAccount: nil,
                             onBack: nil,
                             doneVerify: false)
    }
}
