//
//  AccountEventsProtocol.swift
//  TestLoginization
//
//  Created by Oleh Blef on 6/14/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import Foundation

protocol AccountTestsProtocol {
    func goBack()
    func logOut()
    func deleteAccount()
    func verifyNewPassword()
    func updateNewPassword(text: String) 
    func updateConfirmsNewPassword(text: String)
}
