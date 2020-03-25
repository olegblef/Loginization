//
//  ViewController.swift
//  TestLoginization
//
//  Created by Oleg Podluzhnyi on 5/15/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import UIKit
import IDPRootViewGettable
import ReactiveSwift
import ReactiveCocoa

class RegitrationViewController: UIViewController, RootViewGettable {
    
    // MARK: - Typealiases
    
    typealias RootViewType = RegistrationView
    
    typealias ViewData = RegistrationPresentationModel.ViewData
   
    // MARK: - Private properties
    
    let model: RegistrationPresentationModel
    
    var viewData: ViewData {
        didSet {
            self.view.setNeedsLayout()
        }
    }
    
    // MARK: - Initializations and Deallocations
    
    init() {
        let model = RegistrationPresentationModel()
        self.model = model
        self.viewData = model.data.value
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        let model = RegistrationPresentationModel()
        self.model = model
        self.viewData = model.data.value
        super.init(coder: aDecoder)
    }
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
        self.observeModel()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.rootView?.render(viewData: self.viewData)
    }

    // MARK: - Private methods
    
    private func configUI() {
        self.rootView?.verifyButton?.addTarget(self,
                                               action: #selector(self.onVerify),
                                               for: .touchUpInside)
        
        self.rootView?.goNextButton?.addTarget(self,
                                               action: #selector(self.onGoNext),
                                               for: .touchUpInside)

        self.rootView?.emailTextField?.reactive.continuousTextValues.observeValues { [weak self] text in
            self?.viewData.onUpdateEmail?(text)
        }
        
        self.rootView?.passwordTextField?.reactive.continuousTextValues.observeValues { [weak self] text in
            self?.viewData.onUpdatePassword?(text)
        }
    }
    
    @objc private func onVerify() {
        self.viewData.onVerifyData?()
    }
    
    @objc private func onGoNext() {
        let storyboard = UIStoryboard(name: "Account", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Account") as! AccountViewController
        present(vc, animated: false, completion: nil)
    }
    
    private func observeModel() {
        self.model.data
            .producer
            .take(during: self.reactive.lifetime)
            .observe(on: QueueScheduler.main)
            .startWithValues { [weak self] viewData in
                self?.viewData = viewData
        }
    }
}
