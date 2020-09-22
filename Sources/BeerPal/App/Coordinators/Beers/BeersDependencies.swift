//
//  BeersDependencies.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 23.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

struct BeersDependencies: HasNetworking {
    let networkingService: Networking
    
    init(from dependencies: HasNetworking) {
        self.networkingService = dependencies.networkingService
    }
}
