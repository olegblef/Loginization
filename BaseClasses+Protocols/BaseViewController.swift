//
//  BaseViewController.swift
//  TestLoginization
//
//  Created by Oleh Blef on 5/30/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import UIKit
import IDPRootViewGettable

class BaseViewController<View: UIView>: UIViewController, RootViewGettable {
    
    typealias RootViewType = View
    
    override func loadView() {
        view = View(frame: UIScreen.main.bounds)
    }
}
