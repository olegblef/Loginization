//
//  StartViewData.swift
//  TestLoginization
//
//  Created by Oleh Blef on 6/5/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import Foundation

struct StartViewData: BaseViewData {
    
    var goLogin: (() -> Void)?
    var goRegistration: (() -> Void)?
    
    static var initial: StartViewData {
        return StartViewData(goLogin: nil,
                             goRegistration: nil)
    }
}
