//
//  AccountViewController.swift
//  TestLoginization
//
//  Created by Oleh Blef on 5/22/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import UIKit
import ReactiveSwift

final class AccountViewController<Model: AccountPresentationModel>: BasePresentationModelViewController<Model, AccountView> {

    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configUI()
    }
    
    // MARK - Private methods

    private func configUI() {
        self.rootView?.logOutButton.addTarget(self,
                                              action: #selector(self.onLogOutAccount),
                                              for: .touchUpInside)
        
        self.rootView?.showAccountDataButton.addTarget(self,
                                             action: #selector(self.onShowButton),
                                             for: .touchUpInside)
        
        self.rootView?.resetPasswordButton.addTarget(self,
                                                      action: #selector(self.onResetPasswordButton),
                                                      for: .touchUpInside)
  
        self.rootView?.acceptNewPasswordButton.addTarget(self,
                                                          action: #selector(self.onAcceptNewPassword),
                                                          for: .touchUpInside)
        
        self.rootView?.deleteAccountButton.addTarget(self,
                                                      action: #selector(self.onDeleteButton),
                                                      for: .touchUpInside)
        
        self.rootView?.newPasswordTextField.reactive.continuousTextValues.observeValues { [weak self] text in
            self?.viewData.onUpdateNewPassword?(text)
        }
        
        self.rootView?.confirmNewPasswordTextField.reactive.continuousTextValues.observeValues { [weak self] text in
            self?.viewData.onUpdateConfirmsNewPassword?(text)
        }
        
        let backButton = UIBarButtonItem(title: "Back",
                                         style: UIBarButtonItem.Style.plain,
                                         target: self,
                                         action: #selector(self.onBackButton))
        
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func onAcceptNewPassword() {
        self.viewData.verifyPasswordConfirming?()
        self.rootView?.newPasswordTextField.text = nil
        self.rootView?.confirmNewPasswordTextField.text = nil
    }
    
    @objc private func onResetPasswordButton() {
        self.viewData.onReset?()
        self.rootView?.newPasswordTextField.text = nil
        self.rootView?.confirmNewPasswordTextField.text = nil
    }
    
    @objc private func onShowButton() {
        self.viewData.onShowPassword?()
        self.viewData.onShowEmail?()
    }
    
    // MARK: - Internal properties
    
    @objc func onDeleteButton() {
        self.viewData.onDeleteAccount?()
    }
    
    @objc func onLogOutAccount() {
        self.viewData.onLogOut?()
    }
    
    @objc func onBackButton() {
        self.viewData.onBack?()
    }
}
