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
