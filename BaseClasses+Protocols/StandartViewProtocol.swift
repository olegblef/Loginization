//
//  UIView+Extension.swift
//  TestLoginization
//
//  Created by Oleh Blef on 5/28/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import UIKit
import SnapKit

protocol StandartView: UIView, Renderable { }

extension StandartView {
    
    func createStandartTextFields(first: UITextField, second: UITextField) {
        [first, second].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
            $0.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(30)
            }
            $0.backgroundColor = .lightGray
            $0.textColor = .black
            $0.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        }
        first.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
        }
        second.snp.makeConstraints {
            $0.top.equalTo(first.snp.bottom).offset(30)
        }
        first.placeholder = "Input your email"
        second.placeholder = "Input your password"
    }
    
    func createStandartButton(button: UIButton, upsView: UIView) {
        button.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(button)
        button.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(30)
            $0.top.equalTo(upsView.snp.bottom).offset(30)
        }
        button.backgroundColor = .brown
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        button.setTitle("Go", for: .normal)
    }
}
