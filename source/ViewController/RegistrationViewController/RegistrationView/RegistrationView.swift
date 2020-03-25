//
//  MainView.swift
//  TestLoginization
//
//  Created by Oleg Podluzhnyi on 5/15/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import UIKit
import SnapKit

class RegistrationView: ViewDataGettable<RegistrationPresentationModel>, StandartView {
    
    // MARK: - Internal properties
    
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let messageLabel = UILabel()
    let goButton = UIButton()
    
    // MARK: - Initializations and Deallocations
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.createStandartTextFields(first: self.emailTextField,
                                      second: self.passwordTextField)
        
        self.createStandartButton(button: self.goButton,
                                  upsView: self.passwordTextField)
        
        self.setupLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Renderable
    
    func render(viewData: ViewData) {
        self.emailTextField.text = viewData.email
        self.passwordTextField.text = viewData.password
        self.messageLabel.text = viewData.validationMessage
    }
    
      // MARK - Private methods
    
    private func setupLabel() {
        let label = self.messageLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        label.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.goButton.snp.bottom).offset(30)
            $0.height.equalTo(30)
        }
        label.backgroundColor = .darkGray
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
    }
}
