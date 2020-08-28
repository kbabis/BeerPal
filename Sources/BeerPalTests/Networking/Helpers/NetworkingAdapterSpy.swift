//
//  NetworkingAdapterSpy.swift
//  BeerPalTests
//
//  Created by Krzysztof Babis on 29.08.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Alamofire

final class NetworkingAdapterSpy: RequestAdapter {
    var overheardUrlRequest: URLRequest?
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        self.overheardUrlRequest = urlRequest
        
        return urlRequest
    }
}
