//
//  BeerListItemViewModel.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 23.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class BeerListItemViewModel {
    let beer: Beer
    
    var id: Int { beer.id }
    var name: String { beer.name }
    var description: String { beer.tagline }
    var imageURLString: String? { beer.imageUrl }
    var firstBrewedYear: String { beer.firstBrewed }
    var abvName: String { "abv" }
    var abvValue: String { beer.abv.stringValue }
    var ibuName: String { "ibu" }
    var ibuValue: String? { beer.ibu?.intValue.stringValue }
    
    init(with beer: Beer) {
        self.beer = beer
    }
}

extension BeerListItemViewModel {
    typealias Tag = (name: String, color: UIColor)
}
