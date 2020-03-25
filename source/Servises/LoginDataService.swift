//
//  LoginData.swift
//  TestLoginization
//
//  Created by Oleh Blef on 5/22/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import Foundation
import RealmSwift

class LoginDataService {
    static let shared = LoginDataService()
    
    init() {}
    
    public var realm = try? Realm()
    
    public func create<T: Object>(_ object: T) {
        do {
            try self.realm?.write { [weak self] in
                self?.realm?.add(object)
            }
        } catch {
            print(error)
        }
    }
    
    public func update<T: Object>(_ object: T, with dictionary: [String: Any?]) {
        do {
            try self.realm?.write {
                dictionary.forEach{ (key, value) in
                    object.setValue(value, forKey: key)
                }
            }
        } catch {
            print(error)
        }
    }
    
    public func delete<T: Object>(_ object: T) {
        do {
            try self.realm?.write { [weak self] in
                self?.realm?.delete(object)
            }
        } catch {
            print(error)
        }
    }
}
