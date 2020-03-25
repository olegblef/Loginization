//
//  Coordinator.swift
//  TestLoginization
//
//  Created by Oleh Blef on 6/4/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import UIKit
import ReactiveSwift

final class Coordinator {
    
    // MARK: - Enums
    
    enum LoginEntryPoint {
        case login
        case registration
    }
    
    // MARK: - Private properties
    
    private var info: Store
    private weak var navigationController: UINavigationController?
    private let (lifetime, token) = Lifetime.make()
    
    // MARK: - Initializations and Deallocations
    
    init(navigationController: UINavigationController) {
        self.info = Store()
        self.navigationController = navigationController
    }
    
    func start() {
        self.showStartScreen()
    }
    
      // MARK - Private methods
    
    private func showStartScreen() {
        let model = StartPresentationModel(info: self.info)
        let controller = StartViewController(model: model)
        model.eventRouting
            .take(during: self.lifetime)
            .observeValues{ [weak self] event in
                _ = self?.navigationController?.popViewController(animated: false)
                switch event {
                case .login:
                    self?.showLoginScreen(AutoLoginService())
                case .registration:
                    self?.showRegistrationScreen()
                }
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func showRegistrationScreen() {
        let model = RegistrationPresentationModel(info: self.info)
        let controller = RegistrationViewController(model: model)
        model.eventRouting
            .take(during: self.lifetime)
            .observeValues { [weak self] event in
                _ = self?.navigationController?.popViewController(animated: false)
                switch event {
                case .accaunt:
                    guard let info = self?.info.get().last else { return }
                    let login = AutoLoginService(info)
                    self?.showAccountScreen(login, point: .registration)
                case .back:
                    self?.showStartScreen()
                }
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func showLoginScreen(_ autoLogin: AutoLoginService) {
        let model = LoginPresentationModel(autoLogin, info: self.info)
        let controller = LoginViewController(model: model)
        model.eventRouting
            .take(during: self.lifetime)
            .observeValues { [weak self] event in
                _ = self?.navigationController?.popViewController(animated: false)
                switch event {
                case .accaunt:
                    self?.showAccountScreen(model.autoLogin, point: .login)
                case .back:
                    self?.showStartScreen()
                }
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func showAccountScreen(_ autoLogin: AutoLoginService, point: LoginEntryPoint) {
        let model = AccountPresentationModel(autoLogin, info: self.info)
        let controller = AccountViewController(model: model)
        model.eventRouting
            .take(during: self.lifetime)
            .observeValues { [weak self] event in
                _ = self?.navigationController?.popViewController(animated: false)
                switch event {
                case .back:
                    switch point {
                    case .login:
                        let autoLogin = model.autoLogin
                        self?.showLoginScreen(autoLogin)
                    case .registration:
                        self?.showRegistrationScreen()
                    }
                case .logOut:
                    self?.showStartScreen()
                case .delete:
                    self?.showStartScreen()
                }
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
