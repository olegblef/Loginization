//
//  ViewController.swift
//  TestLoginization
//
//  Created by Oleg Podluzhnyi on 5/15/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import UIKit
import ReactiveSwift

final class RegistrationViewController<Model: RegistrationPresentationModelProtocol>: BasePresentationModelViewController<Model, RegistrationView> {

    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configUI()
    }

    // MARK: - Private methods
    
    private func configUI() {
        
        self.rootView?.goButton.addTarget(self,
                                               action: #selector(self.onGoNext),
                                               for: .touchUpInside)

        self.rootView?.emailTextField.reactive.continuousTextValues.observeValues { [weak self] text in
            self?.viewData.onUpdateEmail?(text)
        }
        
        self.rootView?.passwordTextField.reactive.continuousTextValues.observeValues { [weak self] text in
            self?.viewData.onUpdatePassword?(text)
        }
        let backButton = UIBarButtonItem(title: "Back",
                                         style: UIBarButtonItem.Style.plain,
                                         target: self,
                                         action: #selector(self.onBackButton))
        
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    // MARK: - Internal properties
    
    @objc internal func onGoNext() {
        self.viewData.onVerifyData?()
    }
    
    @objc internal func onBackButton() {
        self.viewData.onBack?()
    }
}
