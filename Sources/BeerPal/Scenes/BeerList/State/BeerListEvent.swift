//
//  BeerListEvent.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 03.10.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

enum BeerListEvent {
    case search(phrase: String)
    case reload
    case loadNextPage
    case handleLoaded(items: [BeerListItemViewModel])
    case error
}
