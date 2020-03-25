//
//  LoginPresentationModelMock.swift
//  TestLoginization
//
//  Created by Oleh Blef on 6/23/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

class LoginPresentationModelMock: LoginTestsProtocol {
    
    var event: LoginEvents?
    
    var inputingEmail = String()
    
    var inputingPassword = String()
    
    let info = Store()
    
    let doneVerify = MutableProperty<Bool>(false)
    
    let (emitter, observer) = Signal<LoginEvents, NoError>.pipe()
    
    var result: Bool {
        get { return self.doneVerify.value }
    }
    
    init() {
        self.emitter.observeValues { [weak self] value in
            self?.event = value
        }
        let support = TestsSupport()
        let infoFeeling = support.generateSharedInfo(3)
        infoFeeling.forEach {
            self.info.add($0)
        }
    }
    
    func goAccount() {
        if self.doneVerify.value {
            self.observer.send(.value(.accaunt))
        }
    }
    
    func goBack() {
        self.observer.send(.value(.back))
    }
    
    func onVerify() {
        self.info.get().forEach {
            if ($0.email == self.inputingEmail && $0.password == self.inputingPassword) {
                self.doneVerify.value = true
            }
        }
    }
    
    func doDoneVerify(_ value: Bool) {
        self.doneVerify.value = value
    }
}
