//
//  RenderableProtocol.swift
//  TestLoginization
//
//  Created by Oleh Blef on 5/30/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//
//
import Foundation

protocol Renderable: class {
    
    associatedtype ViewData
    
    func render(viewData: ViewData)
}
