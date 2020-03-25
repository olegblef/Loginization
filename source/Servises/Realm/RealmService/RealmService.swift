//
//  LoginData.swift
//  TestLoginization
//
//  Created by Oleh Blef on 5/22/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
    
    init() {}
    
    public func create<T: Object>(_ object: T) {
        let realm = try? Realm()
        do {
            try realm?.write {
                realm?.add(object)
            }
        } catch {
            print(error)
        }
    }
    
    public func update<T: Object>(_ object: T, with dictionary: [String: Any?]) {
        let realm = try? Realm()
        do {
            try realm?.write {
                dictionary.forEach{ (key, value) in
                    object.setValue(value, forKey: key)
                }
            }
        } catch {
            print(error)
        }
    }
    
    public func delete<T: Object>(_ object: T) {
        let realm = try? Realm()
        do {
            try realm?.write {
                realm?.delete(object)
            }
        } catch {
            print(error)
        }
    }
    
    public func get<T: Object>() -> Results<T>? {
        let realm = try? Realm()
        return realm?.objects(T.self)
    }
}
