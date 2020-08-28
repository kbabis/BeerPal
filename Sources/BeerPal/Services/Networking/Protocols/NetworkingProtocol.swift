//
//  NetworkingProtocol.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 28.08.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

protocol Networking {
    func request<Response>(_ endpoint: Endpoint<Response>, then completion: @escaping (Swift.Result<Response, Error>) -> Void)
}
