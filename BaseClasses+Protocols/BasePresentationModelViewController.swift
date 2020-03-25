//
//  BasePresentationModelProtocol.swift
//  TestLoginization
//
//  Created by Oleh Blef on 5/30/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import UIKit
import ReactiveSwift

class BasePresentationModelViewController<Model: PresentationModelProtocol, View: StandartView>: BaseViewController<View>, Renderable where Model.ViewData == View.ViewData {
    
    typealias ViewData = Model.ViewData
    
    let model: Model
    
    var viewData: ViewData {
        didSet {
            self.view.setNeedsLayout()
        }
    }
    
    init(model: Model) {
        let model = model
        self.model = model
        self.viewData = model.data.value
//        self.realm = realm
        super.init(nibName: nil, bundle: nil)
        self.observeModel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.render(viewData: self.viewData)
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
    
    func render(viewData: Model.ViewData) {
        self.rootView?.render(viewData: self.viewData)
    }
}
