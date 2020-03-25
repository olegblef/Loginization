//
//  AccountPresentationModel.swift
//  TestLoginization
//
//  Created by Oleh Blef on 5/24/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import ReactiveSwift
import Result

fileprivate typealias AccountProtocol = AccountPresentationModelProtocol
                                        & AccountTestsProtocol
                                        & BaseEventsProtocol

class AccountPresentationModel: BasePresentationModel<AccountViewData>, AccountProtocol {
    
    // MARK: - Typealiases
    
    typealias Events = AccountEvents
    
    // MARK: - Internal properties
    
    var autoLogin = AutoLoginService()
    
    // MARK: - BaseEventsProtocol internal properties
    
    var eventRouting: EventSignal
    
    // MARK: - Private properties
    
    private let observer: EventSignal.Observer
    
    private let (lifetime, token) = Lifetime.make()
    
    private let rightEmail = MutableProperty<String?>(nil)
    
    private let rightPassword = MutableProperty<String?>(nil)
    
    private let newPassword = MutableProperty<String?>(nil)
    
    private let confirmsNewPassword = MutableProperty<String?>(nil)
    
    private let resetHidding = MutableProperty<Bool>(true)
    
    private let acceptEnabling = MutableProperty<Bool>(true)
    
    private let newPasswordColor = MutableProperty<UIColor>(.lightGray)
    
    private let newConfirmsPasswordColor = MutableProperty<UIColor>(.lightGray)
    
    // MARK: - Initializations and Deallocations
    
    init(_ autoLogin: AutoLoginService, info: Store) {
        self.autoLogin = autoLogin
        let dataInternal = MutableProperty(AccountViewData.initial)
        (self.eventRouting, self.observer) = EventSignal.pipe()
        super.init(dataInternal: dataInternal)
        self.info = info
        self.setupData()
    }
    
    // MARK: - AccountEventsProtocol internal methods
    
    func goBack() {
        self.observer.send(.value(.back))
    }
    
    func logOut() {
        self.observer.send(.value(.logOut))
    }
    
    func deleteAccount() {
        guard let acc = self.autoLogin.get() else { return }
        self.info.delete(acc)
        self.observer.send(.value(.delete))
    }
    
    func verifyNewPassword() {
        guard let password = self.confirmsNewPassword.value else { return }
        guard let acc = self.autoLogin.get() else { return }
        
        self.info.updatePassword(acc, newPassword: password)
        self.rightPassword.value = self.confirmsNewPassword.value
        self.autoLogin.updatePassword(password)
        self.resetPassword()
    }
    
    func updateNewPassword(text: String) {
        self.newPassword.value = text
        let color = self.newPasswordColor
        if text.count < 1 {
            color.value = .lightGray
            self.acceptEnabling.value = true
        } else if !isValidPassword(text: text) {
            color.value = .red
            self.acceptEnabling.value = true
        } else {
            color.value = .green
            self.acceptEnabling.value = true
        }
    }
    
    func updateConfirmsNewPassword(text: String) {
        self.confirmsNewPassword.value = text
        let color = self.newConfirmsPasswordColor
        if text.count < 1 {
            color.value = .lightGray
            self.acceptEnabling.value = true
        } else if !isValidPassword(text: text) || text != self.newPassword.value {
            color.value = .red
            self.acceptEnabling.value = true
        } else {
            color.value = .green
            self.acceptEnabling.value = false
        }
    }
    
    
    // MARK - Private methods
    
    private func setupData() {
        let signalProducer = SignalProducer.combineLatest(self.rightEmail,
                                                          self.rightPassword,
                                                          self.newPassword,
                                                          self.confirmsNewPassword,
                                                          self.resetHidding,
                                                          self.acceptEnabling,
                                                          self.newPasswordColor,
                                                          self.newConfirmsPasswordColor)
        
        signalProducer
            .take(during: self.lifetime)
            .observe(on: QueueScheduler.main)
            .startWithValues { [weak self] values in
                if let self = self {
                    let (rightEmail,
                         rightPassword,
                         newPassword,
                         confirmsNewPassword,
                         resetHidding,
                         acceptEnabling,
                         newPasswordColor,
                         newConfirmsPasswordColor) = values
                    self.dataInternal.value = ViewData(email: rightEmail,
                                                       password: rightPassword,
                                                       newPassword: newPassword,
                                                       confirmsNewPassword: confirmsNewPassword,
                                                       onShowEmail: { [weak self] in
                                                        self?.rightEmail.value = self?.autoLogin.get()?.email },
                                                       onShowPassword: { [weak self] in
                                                        self?.rightPassword.value = self?.autoLogin.get()?.password },
                                                       onReset: { [weak self] in
                                                        self?.resetPassword() },
                                                       onUpdateNewPassword: { [weak self] in
                                                        self?.updateNewPassword(text: $0) },
                                                       onUpdateConfirmsNewPassword: { [weak self] in
                                                        self?.updateConfirmsNewPassword(text: $0) },
                                                       verifyPasswordConfirming: { [weak self] in
                                                        self?.verifyNewPassword() },
                                                       onDeleteAccount: { [weak self] in
                                                        self?.deleteAccount() },
                                                       onBack: { [weak self] in
                                                        self?.goBack() },
                                                       onLogOut: { [weak self] in
                                                        self?.logOut() },
                                                       resetHidding: resetHidding,
                                                       acceptEnabling: acceptEnabling,
                                                       newPasswordColor: newPasswordColor,
                                                       newConfirmsPasswordColor: newConfirmsPasswordColor)
                }
        }
    }
    
    private func resetPassword() {
        self.resetHidding.value = !self.resetHidding.value
        self.close()
    }
    
    private func close() {
        self.updateNewPassword(text: "")
        self.updateConfirmsNewPassword(text: "")
    }
}
