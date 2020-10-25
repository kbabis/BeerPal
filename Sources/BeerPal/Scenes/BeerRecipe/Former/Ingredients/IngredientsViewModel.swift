//
//  IngredientsViewModel.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 05.10.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

/*
 3 zakładki: ingredients (+add/remove from the shopping list), method steps + header: tips, food pairing
 */

final class IngredientsViewModel {
    private let beer: Beer
    
    //var ingredientsSections: [Section<String>] { makeSections(of: beer.ingredients) }
    var contributor: String { "~ " + beer.contributedBy }
    var tips: String { beer.brewersTips }
    var foodPairing: [String] { beer.foodPairing }
    
    init(from beer: Beer) {
        self.beer = beer
    }
    
//    private func makeSections(of ingredients: Beer.Ingredients) -> [Section<String>] {
//        var sections = [Section<String>]()
//
//        let maltItems = ingredients.malt.map {
//            String(format: "%@ %@ %@",
//                   $0.amount.description,
//                   R.string.localizable.commonOf(),
//                   $0.name)
//        }
//
//        let maltSection = Section<String>(
//            name: R.string.localizable.beerDetailsIngredientsMalt(),
//            items: maltItems)
//
//        let hopItems = ingredients.hops.map {
//            String(format: "%@ of %@ %@ (%@)",
//                   $0.amount.description,
//                   $0.name,
//                   $0.attribute.description,
//                   $0.add)
//        }
//
//        let hopSection = Section<String>(
//            name: R.string.localizable.beerDetailsIngredientsHops(),
//            items: hopItems)
//
//        sections.append(contentsOf: [maltSection, hopSection])
//
//        if let yeast = ingredients.yeast {
//            let yeastSection = Section<String>(
//                name: R.string.localizable.beerDetailsIngredientsYeast(),
//                items: [yeast])
//
//            sections.append(yeastSection)
//        }
//
//        return sections
//    }
}

// avoid unnecessary guards and default values setting
private extension Beer.Attribute {
    var description: String {
        switch self {
        case .aroma, .aromaAlternative:
            return R.string.localizable.beerDetailsAttributeAroma()
        case .bitter, .bittering, .bitterAlternative:
            return R.string.localizable.beerDetailsAttributeBitterness()
        case .flavour, .flavourAlternative:
            return R.string.localizable.beerDetailsAttributeFlavour()
        case .aromaBitter:
            return R.string.localizable.beerDetailsAttributeAromaBitterness()
        case .twist:
            return rawValue
        case .other:
            return ""
        }
    }
}
