//
//  StartPresentationModel.swift
//  TestLoginization
//
//  Created by Oleh Blef on 6/5/19.
//  Copyright © 2019 Oleg Podluzhnyi. All rights reserved.
//

import ReactiveSwift
import Result

fileprivate typealias StartProtocol = StartPresentationModelProtocol
                                      & StartTestsProtocol
                                      & BaseEventsProtocol

final class StartPresentationModel: BasePresentationModel<StartViewData>, StartProtocol {
    
    // MARK: - Typealiases
    
    typealias Events = StartEvents
    
    // MARK: - BaseEventsProtocol internal properties

    let eventRouting: EventSignal
    
    // MARK: - Private properties
    
    private var observer: EventSignal.Observer
    
    // MARK: - Initializations and Deallocations
    
    init(info: Store) {
        let dataInternal = MutableProperty<StartViewData>(StartViewData.initial)
        (self.eventRouting, self.observer) = EventSignal.pipe()
        super.init(dataInternal: dataInternal)
        self.info = info
        self.setupData()
    }
    
    // MARK: - StartTestsProtocol internal methods
    
    func onLogin() {
        self.observer.send(.value(.login))
    }
    
    func onRegistration() {
        self.observer.send(.value(.registration))
    }
    
    // MARK - Private methods
    
    private func setupData() {
        self.dataInternal.value = ViewData(goLogin: { self.onLogin() },
                                           goRegistration: { self.onRegistration() })
    }
}
