//
//  URL+QueryItem.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 22.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

extension URL {
    mutating func addQueryItem(name: String, value: String?) {
        guard var components = URLComponents(string: absoluteString) else { return }

        var queryItems: [URLQueryItem] = components.queryItems ?? []
        let queryItem = URLQueryItem(name: name, value: value)
        queryItems.append(queryItem)
        components.queryItems = queryItems
        self = components.url!
    }
}
