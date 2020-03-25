//
//  AccountView.swift
//  TestLoginization
//
//  Created by Oleh Blef on 5/22/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import UIKit
import SnapKit

class AccountView: ViewDataGettable<AccountPresentationModel>, StandartView {
    
    // MARK: - Internal properties
    
    let logOutButton = UIButton()
    let showAccountDataButton = UIButton()
    let resetPasswordButton = UIButton()
    let acceptNewPasswordButton = UIButton()
    let deleteAccountButton = UIButton()
    let newPasswordTextField = UITextField()
    let confirmNewPasswordTextField = UITextField()
    
    // MARK: - Private properties

    private let emailLabel = UILabel()
    private let passwordLabel = UILabel()

    // MARK: - Initializations and Deallocations
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.setupLabels()
        self.setupTextFields()
        self.setupButtons()
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
        self.emailLabel.text = viewData.email
        self.passwordLabel.text = viewData.password
        self.newPasswordTextField.backgroundColor = viewData.newPasswordColor
        self.confirmNewPasswordTextField.backgroundColor = viewData.newConfirmsPasswordColor
        [self.newPasswordTextField, self.confirmNewPasswordTextField].forEach {
            $0.isHidden = viewData.resetHidding
        }
        self.acceptNewPasswordButton.isEnabled = !viewData.acceptEnabling
    }
    
      // MARK - Private methods

    private func setupLabels() {
        let email = self.emailLabel
        let password = self.passwordLabel
        [email, password].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
            $0.snp.makeConstraints { label in
                label.leading.trailing.equalToSuperview()
                label.height.equalTo(30)
            }
            $0.backgroundColor = .darkGray
            $0.textAlignment = .center
            $0.textColor = .white
            $0.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        }
        email.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
        }
        password.snp.makeConstraints {
            $0.top.equalTo(email.snp.bottom).offset(30)
        }
    }
    
    private func setupButtons() {
        self.createStandartButton(button: self.showAccountDataButton,
                            upsView: self.passwordLabel)
        
        self.showAccountDataButton.setTitle("Show accounts data", for: .normal)
        
        self.createStandartButton(button: self.resetPasswordButton,
                            upsView: self.showAccountDataButton)
        
        self.resetPasswordButton.setTitle("Reset password", for: .normal)
        
        self.createStandartButton(button: self.acceptNewPasswordButton,
                                  upsView: self.confirmNewPasswordTextField)
        
        self.acceptNewPasswordButton.setTitle("Accept New Password", for: .normal)
        
        self.createStandartButton(button: self.deleteAccountButton,
                                  upsView: self.acceptNewPasswordButton)
        
        self.deleteAccountButton.setTitle("Delete account", for: .normal)
        
        self.createStandartButton(button: self.logOutButton,
                                  upsView: self.deleteAccountButton)
        
        self.logOutButton.setTitle("Log out", for: .normal)
    }
    
    private func setupTextFields() {
        let newPassword = self.newPasswordTextField
        let confirmPassword = self.confirmNewPasswordTextField
        
        self.createStandartTextFields(first: newPassword,
                                      second: confirmPassword)
        
        newPassword.placeholder = "Input new password"
        confirmPassword.placeholder = "Repeat new password"
        
    }
    
    override func updateConstraints() {
        self.newPasswordTextField.snp.updateConstraints { (make) -> Void in
            make.top.equalTo(safeAreaLayoutGuide).offset(250)
        }
        super.updateConstraints()
    }
}
