//
//  StartPresentationModelMock.swift
//  TestLoginization
//
//  Created by Oleh Blef on 6/23/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

class StartPresentationModelMock: StartTestsProtocol {
    
    var event: StartEvents?
    
    let (emitter, observer) = Signal<StartEvents, NoError>.pipe()
    
    init() {
        self.emitter.observeValues { [weak self] value in
            self?.event = value
        }
    }
    
    func onLogin() {
        self.observer.send(.value(.login))
    }
    
    func onRegistration() {
        self.observer.send(.value(.registration))
    }
}
