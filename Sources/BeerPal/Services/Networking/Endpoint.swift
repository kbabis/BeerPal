//
//  Endpoint.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 28.08.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation
import Alamofire

final class Endpoint<Response> {
    typealias Parameters = [String: Any]
    typealias Path = String
    
    let method: HTTPMethod
    let url: URL
    let parameters: Parameters?
    let encoding: ParameterEncoding
    let decode: (Data) throws -> Response
    let headers: HTTPHeaders

    init(method: HTTPMethod = .get,
         url: URL,
         parameters: Parameters? = nil,
         encoding: ParameterEncoding = JSONEncoding.default,
         headers: HTTPHeaders = SessionManager.defaultHTTPHeaders,
         decode: @escaping (Data) throws -> Response) {
        self.method = method
        self.url = url
        self.parameters = parameters
        self.encoding = encoding
        self.headers = headers
        self.decode = decode
    }
}

extension Endpoint where Response: Decodable {
    convenience init(method: HTTPMethod = .get,
                     url: URL,
                     parameters: Parameters? = nil,
                     encoding: ParameterEncoding = JSONEncoding.default,
                     headers: HTTPHeaders = SessionManager.defaultHTTPHeaders) {
        self.init(method: method, url: url, parameters: parameters, encoding: encoding) {
            try JSONDecoder().decode(Response.self, from: $0)
        }
    }
}

extension Endpoint where Response == Void {
    convenience init(method: HTTPMethod = .get,
                     url: URL,
                     parameters: Parameters? = nil,
                     encoding: ParameterEncoding = JSONEncoding.default,
                     headers: HTTPHeaders = SessionManager.defaultHTTPHeaders) {
        self.init(
            method: method,
            url: url,
            parameters: parameters,
            encoding: encoding,
            decode: { _ in () }
        )
    }
}
