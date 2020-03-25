//
//  AccountViewData.swift
//  TestLoginization
//
//  Created by Oleh Blef on 5/23/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import UIKit

struct AccountViewData: BaseViewData {
    
    let email: String?
    let password: String?
    let newPassword: String?
    let confirmsNewPassword: String?
    let onShowEmail: (() -> ())?
    let onShowPassword: (() -> ())?
    let onReset: (() -> ())?
    let onUpdateNewPassword: ((String) -> ())?
    let onUpdateConfirmsNewPassword: ((String) -> ())?
    let verifyPasswordConfirming: (() -> ())?
    let onDeleteAccount: (() -> ())?
    let onBack: (() -> ())?
    let onLogOut: (() -> ())?
    let resetHidding: Bool
    let acceptEnabling: Bool
    let newPasswordColor: UIColor
    let newConfirmsPasswordColor: UIColor
    
    static var initial: AccountViewData {
        return AccountViewData(email: nil,
                               password: nil,
                               newPassword: nil,
                               confirmsNewPassword: nil,
                               onShowEmail: nil,
                               onShowPassword: nil,
                               onReset: nil,
                               onUpdateNewPassword: nil,
                               onUpdateConfirmsNewPassword: nil,
                               verifyPasswordConfirming: nil,
                               onDeleteAccount: nil,
                               onBack: nil,
                               onLogOut: nil,
                               resetHidding: true,
                               acceptEnabling: true,
                               newPasswordColor: .lightGray,
                               newConfirmsPasswordColor: .lightGray)
    }
}
