//
//  NetworkingTests.swift
//  BeerPalTests
//
//  Created by Krzysztof Babis on 28.08.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import XCTest
@testable import BeerPal

final class NetworkingServiceTests: XCTestCase {
    var sut: NetworkingService?
    
    override func setUp() {
        let configuration: URLSessionConfiguration = .ephemeral
        configuration.protocolClasses = [URLProtocolMock.self]
        sut = NetworkingService(configuration: configuration)
    }
    
    func test_request_returnsGivenObject_forSuccessStatusCode() {
        let endpoint = Endpoint<Ticket>(url: makeUrl())
        let expectedTicket = Ticket(id: "Hr94+5r21#$", name: "Alice's Adventures in Wonderland")
        var receivedTicket: Ticket?
        
        guard let data = expectedTicket.encodeJson() else {
            XCTFail("Cannot encode a ticket")
            return
        }
        
        let response = ResponseMock(url: endpoint.url, statusCode: 200, data: data)
        URLProtocolMock.register(response)
        
        let responseExpectation = XCTestExpectation()
        sut?.request(endpoint, then: { (result) in
            receivedTicket = try? result.get()
            responseExpectation.fulfill()
        })
        
        wait(for: [responseExpectation], timeout: 1.0)
        XCTAssertEqual(expectedTicket, receivedTicket)
    }
    
    func test_request_returnsError_forErrorStatusCode() {
        let endpoint = Endpoint(url: makeUrl())
        let response = ResponseMock(url: endpoint.url, statusCode: 500, data: Data(count: 1))
        var receivedResult: Result<Void, Error>?
        URLProtocolMock.register(response)
        
        let responseExpectation = XCTestExpectation()
        sut?.request(endpoint, then: { (result) in
            receivedResult = result
            responseExpectation.fulfill()
        })
        
        wait(for: [responseExpectation], timeout: 1.0)
        XCTAssertThrowsError(try receivedResult?.get())
    }
    
    func test_request_usesGivenEndpoint() {
        let spy = NetworkingAdapterSpy()
        let endpoint = Endpoint(method: .get, url: makeUrl(), headers: ["source": "safari"])
        
        let responseExpectation = XCTestExpectation()
        sut?.adapter = spy
        sut?.request(endpoint, then: { (_) in
            responseExpectation.fulfill()
        })
        
        wait(for: [responseExpectation], timeout: 1.0)
        
        guard let request = spy.overheardUrlRequest else {
            XCTFail("The request was not sent")
            return
        }
        
        XCTAssertTrue(endpoint.isCompatible(with: request))
    }
    
    func test_request_callsCompletion() {
        let endpoint = Endpoint(url: makeUrl())
        var didCallCompletion = false
        
        let responseExpectation = XCTestExpectation()
        sut?.request(endpoint, then: { (_) in
            didCallCompletion = true
            responseExpectation.fulfill()
        })
        
        wait(for: [responseExpectation], timeout: 1.0)
        XCTAssertTrue(didCallCompletion)
    }
    
    private func makeUrl() -> URL {
        return URL(string: "https://sampletest.com")!
    }
}

private extension Endpoint {
    func isCompatible(with request: URLRequest) -> Bool {
        return self.url == request.url
            && self.headers == request.allHTTPHeaderFields
            && self.method.rawValue == request.httpMethod
    }
}
