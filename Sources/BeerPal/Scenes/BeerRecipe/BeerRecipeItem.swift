//
//  BeerRecipeItem.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 21.10.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import RxDataSources

enum BeerRecipeItem {
    case ingredient(name: String)
    case method(name: String, index: Int)
    case pairingFood(name: String)
    case tip(content: String, contributor: String)
}
