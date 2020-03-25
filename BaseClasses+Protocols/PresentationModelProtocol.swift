//
//  PresentationModelProtocol.swift
//  TestLoginization
//
//  Created by Oleg Podluzhnyi on 5/15/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import Foundation
import ReactiveSwift

protocol PresentationModelProtocol {
    
    associatedtype ViewData
    
    var data: Property<ViewData> { get }
}
