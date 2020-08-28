//
//  URLProtocolMock.swift
//  BeerPalTests
//
//  Created by Krzysztof Babis on 28.08.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

final class URLProtocolMock: URLProtocol {
    private static var responses = [ResponseMock]()
    
    static func register(_ mock: ResponseMock) {
        if let foundMockIndex = Self.responses.firstIndex(of: mock) {
            Self.responses.remove(at: foundMockIndex)
        }
        
        Self.responses.append(mock)
    }
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        defer { self.client?.urlProtocolDidFinishLoading(self) }
        
        guard
            let mock = Self.responses.first(where: { $0.url == request.url }),
            let response = HTTPURLResponse(url: mock.url, statusCode: mock.statusCode, httpVersion: "HTTP/1.1", headerFields: mock.headers),
            let data = mock.data
        else { return }
        
        self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        self.client?.urlProtocol(self, didLoad: data)
    }
    
    override func stopLoading() {}
}
