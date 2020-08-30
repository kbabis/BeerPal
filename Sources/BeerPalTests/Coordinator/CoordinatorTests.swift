//
//  CoordinatorTests.swift
//  BeerPalTests
//
//  Created by Krzysztof Babis on 29.08.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import XCTest
@testable import BeerPal

final class CoordinatorTests: XCTestCase {
    var sut: CoordinatorMock?
    
    func test_init_setsGivenNavigationController() {
        let expectedNavigationController = UINavigationController()
        sut = CoordinatorMock(navigationController: expectedNavigationController)
        
        XCTAssertEqual(expectedNavigationController, sut?.navigationController)
    }
    
    func test_startsWithGivenViewController() {
        let expectedViewController = UIViewController()
        sut = CoordinatorMock(navigationController: UINavigationController())
        sut?.startingViewController = expectedViewController
        
        XCTAssertEqual(expectedViewController, sut?.navigationController.viewControllers.first)
    }
}
