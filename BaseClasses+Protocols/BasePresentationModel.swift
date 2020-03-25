//
//  BasePresentationModel.swift
//  TestLoginization
//
//  Created by Oleh Blef on 5/30/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa

class BasePresentationModel<Data: BaseViewData>: GettingInfo, PresentationModelProtocol {
    
    typealias ViewData = Data
    
    var data: ReactiveSwift.Property<ViewData>

    let dataInternal: MutableProperty<ViewData>
    
    init(dataInternal: MutableProperty<ViewData>) {
        self.dataInternal = dataInternal
        self.data = Property(capturing: dataInternal)
    }
}
