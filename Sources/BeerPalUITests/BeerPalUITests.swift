//
//  BeerPalUITests.swift
//  BeerPalUITests
//
//  Created by Krzysztof Babis on 25.08.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import XCTest

class BeerPalUITests: XCTestCase {
    override func setUp() {
        continueAfterFailure = false
    }

    override func tearDown() {}

    func testExample() {
        let app = XCUIApplication()
        app.launch()
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}

