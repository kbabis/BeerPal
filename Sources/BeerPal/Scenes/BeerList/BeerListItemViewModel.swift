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
    var tags: [Tag] { makeTags(for: beer) }
    
    init(with beer: Beer) {
        self.beer = beer
    }
    
    private func makeTags(for beer: Beer) -> [Tag] {
        var tags: [Tag] = []
        
        if let firstBrewedYear = Int(firstBrewedYear), firstBrewedYear > 2016 {
            tags.append((name: "New", color: .systemBlue))
        }
        
        if let bitterness = beer.ibu, bitterness > 55 {
             tags.append((name: "Bitter", color: .brown))
        }
        
        if beer.abv > 6 {
            tags.append((name: "Strong", color: .systemRed))
        } else if beer.abv < 4 {
            tags.append((name: "Light", color: .systemGreen))
        }
        
        return tags
    }
}

extension BeerListItemViewModel {
    typealias Tag = (name: String, color: UIColor)
}
