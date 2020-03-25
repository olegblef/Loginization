//
//  StartView.swift
//  TestLoginization
//
//  Created by Oleh Blef on 5/26/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import UIKit
import SnapKit

class StartView: ViewDataGettable<StartPresentationModel>, StandartView  {
    
    // MARK: - Internal properties
    
    let startLable = UILabel()
    let loginButton = UIButton()
    let registrationButton = UIButton()
 
    // MARK: - Initializations and Deallocations
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.setupLabel()
        self.setupButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Override methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Renderable
    
    func render(viewData: StartViewData) {
        
    }
    
    // MARK - Private methods
    
    private func setupLabel() {
        let label = self.startLable
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        label.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(30)
        }
        label.backgroundColor = .darkGray
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.text = "Hello, friend"
    }
    
    private func setupButtons() {
        let login = self.loginButton
        let registration = self.registrationButton
        [login, registration].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
            $0.snp.makeConstraints { button in
                button.leading.trailing.equalToSuperview()
                button.height.equalTo(30)
            }
            $0.backgroundColor = .brown
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        }
        login.snp.makeConstraints {
            $0.top.equalTo(self.startLable.snp.bottom).offset(30)
        }
        registration.snp.makeConstraints {
            $0.top.equalTo(login.snp.bottom).offset(30)
        }
        login.setTitle("Login", for: .normal)
        registration.setTitle("Registration", for: .normal)
    }
}
