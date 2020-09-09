//
//  CacheTests.swift
//  BeerPalTests
//
//  Created by Krzysztof Babis on 09.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import XCTest
@testable import BeerPal

final class CacheTests: XCTestCase {
    func test_setsGivenValue_forGivenKey() {
        let sut = MockCache<String, String>()
        let key = "name"
        let expectedValue = "Bill"
        
        sut.insert(expectedValue, forKey: key)
        let receivedValue = sut.value(forKey: key)
        
        XCTAssertEqual(expectedValue, receivedValue)
    }
    
    func test_removesGivenValue() {
        let sut = MockCache<String, Int>()
        let key = "age"
        
        sut.insert(15, forKey: key)
        sut.removeValue(forKey: key)
        let receivedValue = sut.value(forKey: key)
        
        
        XCTAssertEqual(receivedValue, nil)
    }
}
