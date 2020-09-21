//
//  BeerListEndpoint.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 09.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

extension API {
    static func beerList(name: String?, at page: Int) -> Endpoint<[Beer]> {
        var builder = URLBuilder(scheme: "https", host: "api.punkapi.com", version: "v2")
                        .set(path: "beers")
                        .addQueryItem(name: "page", value: String(page))
            
        if let name = name {
            builder = builder.addQueryItem(name: "beer_name", value: name)
        }
            
        return Endpoint(method: .get, url: builder.build()!)
    }
}
