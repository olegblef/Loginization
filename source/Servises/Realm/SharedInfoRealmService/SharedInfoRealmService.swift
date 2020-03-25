//
//  SharedInfoRealmService.swift
//  TestLoginization
//
//  Created by Oleh Blef on 6/2/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import Foundation
import RealmSwift

class SharedInfoRealmService {
    private let realmService = RealmService()
    
    public func create(info: SharedInfoRealm) {
        self.realmService.create(info)
    }
    
    public func update(object: SharedInfoRealm, dict: [String: String?]) {
        self.realmService.update(object, with: dict)
    }
    
    public func delete(object: SharedInfoRealm) {
        self.realmService.delete(object)
    }
    
    public func get() -> Results<SharedInfoRealm>? {
        return self.realmService.get()
    }
}
