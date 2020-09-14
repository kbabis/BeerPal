//
//  AppDependencies.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 30.08.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

struct AppDependencies: HasNetworking {
    let networkingService: Networking
    
    init() {
        let networkingService = NetworkingService()
        networkingService.adapter = RequestInterceptor()
        self.networkingService = networkingService
    }
}
