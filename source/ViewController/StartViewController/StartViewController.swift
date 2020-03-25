//
//  StartViewController.swift
//  TestLoginization
//
//  Created by Oleh Blef on 5/26/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import UIKit
import ReactiveSwift

final class StartViewController<Model: StartPresentationModelProtocol>: BasePresentationModelViewController<Model, StartView> {

    // MARK: - Override methods

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }
    
      // MARK - Private methods
    
    private func setupUI() {
        self.rootView?.loginButton.addTarget(self,
                                             action: #selector(self.onLoginButton),
                                             for: .touchUpInside)
        
        self.rootView?.registrationButton.addTarget(self,
                                             action: #selector(self.onRegistrationButton),
                                             for: .touchUpInside)
        
        let backButton = UIBarButtonItem(title: "",
                                         style: .plain,
                                         target: self,
                                         action: nil)
        
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    // MARK: - Internal properties
    
    @objc internal func onLoginButton() {
        self.viewData.goLogin?()
    }
    
    @objc internal func onRegistrationButton() {
        self.viewData.goRegistration?()
    }
}
