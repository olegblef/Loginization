//
//  BaseEventsProtocol.swift
//  TestLoginization
//
//  Created by Oleh Blef on 6/17/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

protocol BaseEventsProtocol: class {
    associatedtype Events
    
    typealias EventSignal = Signal<Events, NoError>
    
    var eventRouting: EventSignal { get }
}
