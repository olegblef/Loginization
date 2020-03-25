//
//  PresentationModel.swift
//  TestLoginization
//
//  Created by Oleg Podluzhnyi on 5/16/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import ReactiveSwift
import Result

fileprivate typealias RegistrationProtocol = RegistrationPresentationModelProtocol
                                             & RegistrationTestsProtocol
                                             & BaseEventsProtocol

class RegistrationPresentationModel: BasePresentationModel<RegistrationViewData>, RegistrationProtocol {
    
    // MARK: - Typealiases
    
    typealias Events = RegistrationEvents
    
    // MARK: - BaseEventsProtocol internal properties

    var eventRouting: EventSignal
    
    // MARK: - Private properties
    
    private let observer: EventSignal.Observer
    
    private let (lifetime, token) = Lifetime.make()
    
    private let inputingEmail = MutableProperty<String?>(nil)
    
    private let inputingPassword = MutableProperty<String?>(nil)
    
    private let message = MutableProperty<String?>(nil)
    
    // MARK: - Initializations and Deallocations
    
    init(info: Store) {
        let dataInternal = MutableProperty<RegistrationViewData>(RegistrationViewData.initial)
        (self.eventRouting, self.observer) = EventSignal.pipe()
        super.init(dataInternal: dataInternal)
        self.info = info
        self.setupData()
    }
    
    // MARK: - RegistrationTestsProtocol internal methods
    
    func goBack() {
        self.observer.send(.value(.back))
    }
    
    func onVerify() {
        guard let email = self.inputingEmail.value else { return }
        guard let password = self.inputingPassword.value else { return }
        
        if !isValidEmail(text: email) {
            self.message.value = "Please, check your email"
        } else if !isValidPassword(text: password) {
            self.message.value = "Please, check your password"
        } else {
            if !self.info.findSimilarEmail(email: email) {
                self.message.value = "Your account was verified"
                self.saveLoginInfo(email: email, password: password)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    self.observer.send(.value(.accaunt))
                })
            } else {
                self.message.value = "This email is exist already"
            }
        }
    }
    
    // MARK: - Private methods
    
    private func setupData() {
        let signalProducer = SignalProducer.combineLatest(self.inputingEmail.producer,
                                                          self.inputingPassword.producer,
                                                          self.message.producer)
        
        signalProducer
            .take(during: self.lifetime)
            .observe(on: QueueScheduler.main)
            .startWithValues { [weak self] values in
                if let self = self {
                    let (inputingEmail, inputingPassword, message) = values
                    self.dataInternal.value = ViewData(email: inputingEmail,
                                                       password: inputingPassword,
                                                       validationMessage: message,
                                                       onVerifyData: { [weak self] in
                                                        self?.onVerify()},
                                                       onUpdateEmail: { [weak self] in
                                                        self?.inputingEmail.value = $0 },
                                                       onUpdatePassword: { [weak self] in
                                                        self?.inputingPassword.value = $0 },
                                                       onBack: { [weak self] in
                                                        self?.goBack() })
                }
        }
    }
    
    private func saveLoginInfo(email: String, password: String) {
        self.info.add(SharedInfo(email: email, password: password))
    }
}
