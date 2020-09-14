//
//  TabsDependencies.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 29.08.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

struct TabsDependencies: HasNetworking {
    let networkingService: Networking
    
    init(from dependencies: HasNetworking) {
        self.networkingService = dependencies.networkingService
    }
}
