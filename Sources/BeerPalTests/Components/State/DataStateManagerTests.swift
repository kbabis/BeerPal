//
//  DataStateManagerTests.swift
//  BeerPalTests
//
//  Created by Krzysztof Babis on 08.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import RxSwift
import XCTest
@testable import BeerPal

final class DataStateManagerTests: XCTestCase {
    var disposeBag: DisposeBag!
    
    override func setUp() {
        disposeBag = DisposeBag()
    }
    
    func test_init_setsIdleStateOnDefault() {
        let sut = DataStateManager(queueName: "com.beerpal.tests.datastatemanager")
        let expectedState = DataState.idle
        var receivedState: DataState?
        let expectation = XCTestExpectation(description: "Produce a new state in 1 second")
        
        sut.currentState.drive(onNext: { (state) in
            receivedState = state
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(expectedState, receivedState)
    }
    
    func test_updateState_setsGivenState() {
        let sut = DataStateManager(queueName: "com.beerpal.tests.datastatemanager")
        let expectedState = DataState.loading
        var receivedState: DataState?
        let expectation = XCTestExpectation(description: "Produce a new state in 1 second")
        
        sut.update(expectedState)
        sut.currentState.drive(onNext: { (state) in
            receivedState = state
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(expectedState, receivedState)
    }
}
