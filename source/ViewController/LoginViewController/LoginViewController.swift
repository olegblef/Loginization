//
//  LoginViewController.swift
//  TestLoginization
//
//  Created by Oleh Blef on 5/27/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import UIKit
import ReactiveSwift

final class LoginViewController<Model: LoginPresentationModelProtocol>: BasePresentationModelViewController<Model, LoginView> {

    // MARK: - Override methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configUI()
    }
    
      // MARK - Private methods
    
    private func configUI() {
        self.rootView?.emailTextField.reactive.continuousTextValues.observeValues { [weak self] text in
            self?.viewData.onUpdateEmail?(text)
            self?.viewData.verifyAccaunt?()
        }
        
        self.rootView?.passwordTextField.reactive.continuousTextValues.observeValues { [weak self] text in
            self?.viewData.onUpdatePassword?(text)
            self?.viewData.verifyAccaunt?()
        }
        
        self.rootView?.goButton.addTarget(self,
                                           action: #selector(self.onGoButton),
                                           for: .touchUpInside)
        
        let backButton = UIBarButtonItem(title: "Back",
                                         style: UIBarButtonItem.Style.plain,
                                         target: self,
                                         action: #selector(self.onBackButton))
        
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc internal func onGoButton() {
        self.viewData.onAccount?()
    }
    
    @objc internal func onBackButton() {
        self.viewData.onBack?()
    }
}
