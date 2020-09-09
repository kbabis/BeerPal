//
//  BeerListEndpoint.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 09.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

extension API {
    static func beers() -> Endpoint<BeerListResponseModel> {
        let url = URLBuilder()
        .set(path: "beers")
        .build()!
        
        return Endpoint(method: .get, url: url)
    }
}
