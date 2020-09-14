//
//  RequestInterceptor.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 14.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Alamofire

final class RequestInterceptor: RequestAdapter {
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var modifiedUrlRequest = urlRequest
        modifiedUrlRequest.url?.addQueryItem(name: "key", value: AppConfig.API.key)
        return modifiedUrlRequest
    }
}

private extension URL {
    mutating func addQueryItem(name: String, value: String?) {
        guard var components = URLComponents(string: absoluteString) else { return }

        var queryItems: [URLQueryItem] = components.queryItems ?? []
        let queryItem = URLQueryItem(name: name, value: value)
        queryItems.append(queryItem)
        components.queryItems = queryItems
        self = components.url!
    }
}
