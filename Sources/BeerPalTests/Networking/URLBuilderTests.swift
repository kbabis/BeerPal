//
//  URLBuilderTests.swift
//  BeerPalTests
//
//  Created by Krzysztof Babis on 27.08.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import XCTest
@testable import BeerPal

final class URLBuilderTests: XCTestCase {
    var sut: URLBuilder?
    
    override func tearDown() {
        sut = nil
    }

    func test_givenValidUrlComponents_returnsURL() {
        sut = URLBuilder(scheme: "https", host: "google.com", version: nil)
        let expectedUrlString = "https://google.com"
        let receivedUrlString = sut?.build()?.absoluteString
        XCTAssertEqual(expectedUrlString, receivedUrlString)
    }

    func test_givenPath_setsPath() {
        sut = URLBuilder(version: nil)
        let expectedPath = "/expected"
        let receivedPath = sut?
                            .set(path: expectedPath)
                            .build()?
                            .path
        XCTAssertEqual(expectedPath, receivedPath)
    }
    
    func test_givenPort_setsPort() {
        sut = URLBuilder(version: nil)
        let expectedPort = 443
        let receivedPort = sut?
                            .set(port: expectedPort)
                            .build()?
                            .port
        XCTAssertEqual(expectedPort, receivedPort)
    }
    
    func test_givenQueryItem_setsQueryItem() {
        sut = URLBuilder()
        let expectedQuery = "name=test"
        let receivedQuery = sut?
                            .addQueryItem(name: "name", value: "test")
                            .build()?
                            .query
        XCTAssertEqual(expectedQuery, receivedQuery)
    }
}
