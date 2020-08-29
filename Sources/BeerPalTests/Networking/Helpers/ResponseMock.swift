//
//  ResponseMock.swift
//  BeerPalTests
//
//  Created by Krzysztof Babis on 28.08.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

struct ResponseMock {
    let url: URL
    let statusCode: Int
    let headers: [String: String]
    let data: Data?
    
    init(url: URL, statusCode: Int, additionalHeaders: [String: String] = [:], contentType: ContentType = .json, data: Data? = nil) {
        self.url = url
        self.statusCode = statusCode
        self.data = data
        
        var headers = additionalHeaders
        headers["Content-Type"] = contentType.headerValue
        self.headers = headers
    }
}

extension ResponseMock: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.url == rhs.url
    }
}

extension ResponseMock {
    enum ContentType: String {
        case json
        case html
        case imagePNG
        
        var headerValue: String {
            switch self {
            case .json:
                return "application/json; charset=utf-8"
            case .html:
                return "text/html; charset=utf-8"
            case .imagePNG:
                return "image/png"
            }
        }
    }
}

