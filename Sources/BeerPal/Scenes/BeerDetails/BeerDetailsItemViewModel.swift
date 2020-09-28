//
//  BeerDetailsItemViewModel.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 24.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

struct BeerDetailsItemViewModel {
    private let beer: Beer
    
    var name: String { beer.name }
    var tagline: String { beer.tagline.replacingOccurrences(of: ".", with: "") }
    var abv: String { beer.abv.stringValue.replacingOccurrences(of: ".", with: ",") }
    var gravity: String { beer.targetFg.stringValue }
    var bitterness: String? { beer.ibu?.intValue.stringValue }
    var ebc: String? { beer.ebc?.intValue.stringValue }
    var description: String { beer.description }
    var attenuationLevel: String { beer.attenuationLevel.stringValue + "%" }
    var contributor: String { "~ " + beer.contributedBy }
    var tips: String { beer.brewersTips }
    var method: [BrewageMethodStep] { makeMethodSteps(from: beer.method) }
    var ingredientsSections: [Section<String>] { makeSections(of: beer.ingredients) }
    var foodPairing: [String] { beer.foodPairing }
    var imageURL: String? { beer.imageUrl }
    
    private func makeSections(of ingredients: Beer.Ingredients) -> [Section<String>] {
        let maltItems = ingredients.malt.map {
            String(format: "%@ %@ %@",
                   $0.amount.description,
                   R.string.localizable.commonOf(),
                   $0.name)
        }
        
        let maltSection = Section<String>(
            name: R.string.localizable.beerDetailsIngredientsMalt(),
            items: maltItems)
        
        let hopItems = ingredients.hops.map {
            String(format: "%@ of %@ %@ (%@)",
                   $0.amount.description,
                   $0.name,
                   $0.attribute.description,
                   $0.add)
        }
        
        let hopSection = Section<String>(
            name: R.string.localizable.beerDetailsIngredientsHops(),
            items: hopItems)
        
        let yeastSection = Section<String>(
            name: R.string.localizable.beerDetailsIngredientsYeast(),
            items: [ingredients.yeast])
        
        return [maltSection, hopSection, yeastSection]
    }
    
    private func makeMethodSteps(from method: Beer.Method) -> [BrewageMethodStep] {
        var steps: [BrewageMethodStep] = []
        
        for mash in method.mashTemp {
            var mashStep = mash.temp.description
            
            if let duration = mash.duration {
                mashStep.append(String(format: " for %d min", duration))
            }
            
            steps.append(mashStep)
        }
            
        let fermentationStep = R.string.localizable.beerDetailsMethodFerment() + " " + method.fermentation.temp.description
        steps.append(fermentationStep)
        
        if let twist = method.twist {
            let twistStep = R.string.localizable.beerDetailsMethodTwist() + ": " + twist
            steps.append(twistStep)
        }
        
        return steps
    }
    
    init(from beer: Beer) {
        self.beer = beer
    }
}

extension BeerDetailsItemViewModel {
    typealias BrewageMethodStep = String
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
        }
    }
}

private extension Beer.Measure {
    var description: String {
        return String(format: "%.1d %@", value, unit)
    }
}

private extension Double {
    var stringValue: String {
        return String(self)
    }
    
    var intValue: Int {
        return Int(self)
    }
}

private extension Int {
    var stringValue: String {
        return String(self)
    }
}


