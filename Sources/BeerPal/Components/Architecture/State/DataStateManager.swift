//
//  DataStateManager.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 01.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import RxCocoa

final class DataStateManager {
    private let queue: DispatchQueue
    private let stateRelay: BehaviorRelay<DataState>
    var currentState: Driver<DataState> { return stateRelay.asDriver() }
    
    init(defaultState: DataState = .idle, queueName: String = "com.beerpal.datastatemanager") {
        self.stateRelay = BehaviorRelay<DataState>(value: defaultState)
        self.queue = DispatchQueue(label: queueName)
    }
    
    func updateState(_ state: DataState) {
        queue.sync { stateRelay.accept(state) }
    }
}
