//
//  NSLock+Extention.swift
//  TestLoginization
//
//  Created by Oleh Blef on 6/10/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import Foundation

extension NSLocking {
    
    public func locked<Result>(_ execute: () -> Result) -> Result {
        self.lock()
        defer { self.unlock() }
        
        return execute()
    }
}
