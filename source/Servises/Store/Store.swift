//
//  Store.swift
//  TestLoginization
//
//  Created by Oleh Blef on 6/10/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import Foundation

final class Store {
    
    // MARK: - Private properties
    
    private var accounts = [SharedInfo]()
    private let queue = DispatchQueue(label: "store", qos: .background)
    
    // MARK: - Public methods
    
    public func add(_ account: SharedInfo) {
        self.accounts.append(account)
    }
    
    public func delete(_ account: SharedInfo) {
        self.queue.async() {
            let acc = self.accounts
            for (index, info) in acc.enumerated() {
                if info == account {
                    self.accounts.remove(at: index)
                }
            }
        }
    }
    
    public func updateEmail(_ account: SharedInfo, newEmail: String) {
        self.queue.async() {
            let acc = self.accounts
            for (index, info) in acc.enumerated() {
                if info == account && isValidEmail(text: newEmail) {
                    self.accounts.remove(at: index)
                    self.accounts.insert(SharedInfo(email: newEmail, password: info.password), at: index)
                }
            }
        }
    }
    
    public func updatePassword(_ account: SharedInfo, newPassword: String) {
        self.queue.async() {
            let acc = self.accounts
            for (index, info) in acc.enumerated() {
                if info == account && isValidPassword(text: newPassword) {
                    self.accounts.remove(at: index)
                    self.accounts.insert(SharedInfo(email: info.email, password: newPassword), at: index)
                }
            }
        }
    }
    
    public func get() -> [SharedInfo] {
        var result: [SharedInfo] = []
        self.queue.sync { result =  self.accounts }
        return result
    }
    
    public func findSimilarEmail(email: String) -> Bool {
        var result = false
        self.queue.sync {
            result = self.accounts.contains(where: { $0.email == email })
        }
        return result
    }
}
