//
//  LoginViewData.swift
//  TestLoginization
//
//  Created by Oleg Podluzhnyi on 5/15/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import Foundation

struct RegistrationViewData: BaseViewData {
    
    let email: String?
    let password: String?
    let validationMessage: String?
    let onVerifyData: (() -> ())?
    let onUpdateEmail: ((String) -> ())?
    let onUpdatePassword: ((String) -> ())?
    let onBack: (() -> ())?
    
    static var initial: RegistrationViewData {
        return RegistrationViewData(email: nil,
                             password: nil,
                             validationMessage: nil,
                             onVerifyData: nil,
                             onUpdateEmail: nil,
                             onUpdatePassword: nil,
                             onBack: nil)
    }
}
