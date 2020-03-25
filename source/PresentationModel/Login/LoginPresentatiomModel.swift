//
//  LoginPresentatiomModel.swift
//  TestLoginization
//
//  Created by Oleh Blef on 5/27/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import ReactiveSwift
import Result

fileprivate typealias LoginProtocol = LoginPresentationModelProtocol
                                      & LoginTestsProtocol
                                      & BaseEventsProtocol

class LoginPresentationModel: BasePresentationModel<LoginViewData>, LoginProtocol {
    
    // MARK: - Typealiases
    
    typealias Events = LoginEvents
    
    // MARK: - Internal properties
    
    var autoLogin = AutoLoginService()
    
    // MARK: - BaseEventsProtocol internal properties
    
    var eventRouting: EventSignal
    
    // MARK: - Private properties
    
    private var observer: EventSignal.Observer
    
    private let (lifetime, token) = Lifetime.make()
    
    private let inputingEmail = MutableProperty<String?>(nil)
    
    private let inputingPassword = MutableProperty<String?>(nil)
    
    private let doneVerify = MutableProperty<Bool>(false)
    
    // MARK: - Initializations and Deallocations
    
    init(_ autoLogin: AutoLoginService, info: Store) {
        let dataInternal = MutableProperty<LoginViewData>(LoginViewData.initial)
        (self.eventRouting, self.observer) = EventSignal.pipe()
        super.init(dataInternal: dataInternal)
        self.info = info
        self.autoLogin = autoLogin
        self.inputingEmail.value = autoLogin.get()?.email
        self.inputingPassword.value = autoLogin.get()?.password
        self.setupData()
    }
    
    // MARK: - Public methods
    
    public func getAccount() -> SharedInfo {
        return SharedInfo(email: self.inputingEmail.value ?? "",
                          password: self.inputingPassword.value ?? "")
    }
    
    // MARK: - LoginTestsProtocol internal methods
    
    func goAccount() {
        if self.doneVerify.value {
            self.observer.send(.value(.accaunt))
        }
    }
    
    func goBack() {
        self.observer.send(.value(.back))
    }
    
    func onVerify() {
        guard let email = self.inputingEmail.value else { return }
        guard let password = self.inputingPassword.value else { return }
        self.info.get().forEach {
            if ($0.email == email && $0.password == password) {
                self.doneVerify.value = true
            }
        }
        self.autoLogin.updatePassword(password)
        self.autoLogin.updateEmail(email)
    }
    
    // MARK - Private methods
    
    private func setupData() {
        let signalProducer = SignalProducer.combineLatest(self.inputingEmail.producer,
                                                          self.inputingPassword.producer,
                                                          self.doneVerify.producer)
        
        signalProducer
            .take(during: self.lifetime)
            .observe(on: QueueScheduler.main)
            .startWithValues { [weak self] values in
                if let self = self {
                    let (inputingEmail, inputingPassword, doneVerify) = values
                    self.dataInternal.value = ViewData(email: inputingEmail,
                                                       password: inputingPassword,
                                                       onUpdateEmail: { [weak self] in
                                                        self?.inputingEmail.value = $0 },
                                                       onUpdatePassword: { [weak self] in
                                                        self?.inputingPassword.value = $0 },
                                                       verifyAccaunt: { [weak self] in
                                                        self?.onVerify() },
                                                       onAccount: { [weak self] in
                                                        self?.goAccount() },
                                                       onBack: { [weak self] in
                                                        self?.goBack() },
                                                       doneVerify: doneVerify)
                }
        }
    }
}
