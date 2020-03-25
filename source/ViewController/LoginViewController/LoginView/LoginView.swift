//
//  LoginView.swift
//  TestLoginization
//
//  Created by Oleh Blef on 5/27/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import UIKit

class LoginView: ViewDataGettable<LoginPresentationModel>, StandartView {

    // MARK - Internal properties
    
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let goButton = UIButton()
    
 // MARK: - Initializations and Deallocations
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.createStandartTextFields(first: self.emailTextField,
                                      second: self.passwordTextField)
        
        self.createStandartButton(button: self.goButton,
                                  upsView: self.passwordTextField)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Override methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Renderable
    
    func render(viewData: ViewData) {
        self.emailTextField.text = viewData.email
        self.passwordTextField.text = viewData.password
    }
}
