//
//  DecodableBoolTests.swift
//  BeerPalTests
//
//  Created by Krzysztof Babis on 10.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import XCTest
@testable import BeerPal

private struct Solution: Decodable {
    @DecodableBool var isLookingGood: Bool
}

final class DecodableBoolTests: XCTestCase {
    func test_wrapperWorksWithStringValue() {
        let jsonData = "{\"isLookingGood\":\"Y\"}".data(using: .utf8)!
        let decodedObject = try? JSONDecoder().decode(Solution.self, from: jsonData)
        
        XCTAssertTrue(decodedObject?.isLookingGood == true)
    }
}
