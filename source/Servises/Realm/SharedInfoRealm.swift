//
//  SharedInfo.swift
//  TestLoginization
//
//  Created by Oleh Blef on 5/22/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class SharedInfoRealm: Object {
    dynamic var email: String = ""
    dynamic var password: String = ""

    convenience init(info: SharedInfo) {
        self.init()
        self.email = info.email
        self.password = info.password
    }
}
