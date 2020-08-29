//
//  EndpointTests.swift
//  BeerPalTests
//
//  Created by Krzysztof Babis on 28.08.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import XCTest
@testable import BeerPal
import Alamofire

final class EndpointTests: XCTestCase {
    func test_init_setsGivenURL() {
        let expectedUrl = makeUrl()
        let sut = Endpoint(url: expectedUrl)
        let receivedUrl = sut.url
        
        XCTAssertEqual(expectedUrl, receivedUrl)
    }
    
    func test_init_setsGivenHttpMethod() {
        let expectedMethod: HTTPMethod = .post
        let sut = Endpoint(method: .post, url: makeUrl())
        let receivedMethod = sut.method
        
        XCTAssertEqual(expectedMethod, receivedMethod)
    }
    
    func test_init_setsGivenParameters() {
        let expectedParameters = ["client": "safari"]
        let sut = Endpoint(url: makeUrl(), parameters: expectedParameters)
        
        guard let receivedParameters = sut.parameters else {
            XCTFail("Received parameters field is set to nil")
            return
        }
        
        XCTAssertTrue(NSDictionary(dictionary: expectedParameters).isEqual(to: receivedParameters))
    }
    
    func test_init_setsGivenHeaders() {
        let expectedHeaders = ["customHeader": "test"]
        let sut = Endpoint(url: makeUrl(), headers: expectedHeaders)
        let receivedHeaders = sut.headers
        
        XCTAssertTrue(NSDictionary(dictionary: expectedHeaders).isEqual(to: receivedHeaders))
    }
    
    private func makeUrl() -> URL {
        return URL(string: "https://google.pl")!
    }
}
