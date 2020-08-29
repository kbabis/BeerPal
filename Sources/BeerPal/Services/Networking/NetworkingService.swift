//
//  NetworkingService.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 28.08.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Alamofire

final class NetworkingService {
    private let sessionManager: Alamofire.SessionManager
    private let requestQueue: DispatchQueue
    
    var adapter: RequestAdapter? {
        didSet { self.sessionManager.adapter = adapter }
    }
    
    init(
        configuration: URLSessionConfiguration = .default,
        requestQueue: DispatchQueue = DispatchQueue(label: "com.beerpal.session.requestQueue")
    ) {
        configuration.urlCredentialStorage = nil
        self.sessionManager = Alamofire.SessionManager(configuration: configuration)
        self.requestQueue = requestQueue
    }
}

extension NetworkingService: Networking {
    func request<Response>(_ endpoint: Endpoint<Response>, then completion: @escaping (Swift.Result<Response, Error>) -> Void) {
        let request = self.sessionManager.request(endpoint.url, method: endpoint.method, parameters: endpoint.parameters, encoding: endpoint.encoding, headers: endpoint.headers)
        
        request
            .validate(statusCode: 200...399)
            .responseData(queue: self.requestQueue) { (response) in
                let result = response.result.flatMap(endpoint.decode)
    
                switch result {
                case let .success(value):
                    completion(.success(value))
                case let .failure(error):
                    completion(.failure(error))
                }
        }
    }
}
