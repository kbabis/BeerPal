//
//  BeerListResponseModel.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 09.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

struct Beer: Codable {
    let id: Int
    let name: String
    let tagline: String
    let firstBrewed: String
    let description: String
    let imageUrl: String?
    let abv: Double
    let ibu: Double?
    let targetFg: Int
    let targetOg: Double
    let ebc: Double?
    let srm: Double?
    let ph: Double?
    let attenuationLevel: Double
    let volume: Measure
    let boilVolume: Measure
    let method: Method
    let ingredients: Ingredients
    let foodPairing: [String]
    let brewersTips: String
    let contributedBy: String
    
    struct Ingredients: Codable {
        let malt: [Malt]
        let hops: [Hop]
        let yeast: String
    }

    struct Hop: Codable {
        let name: String
        let add: String
        let amount: Measure
        let attribute: Attribute
    }

    struct Malt: Codable {
        let name: String
        let amount: Measure
    }

    struct Method: Codable {
        let mashTemp: [MashTemperature]
        let fermentation: Fermentation
        let twist: String?
    }

    struct Fermentation: Codable {
        let temp: Measure
    }

    struct MashTemperature: Codable {
        let temp: Measure
        let duration: Int?
    }
    
    struct Measure: Codable {
        let value: Double
        let unit: String
    }
    
    enum Attribute: String, Codable {
        case aroma = "aroma"
        case aromaAlternative = "Aroma"
        case aromaBitter = "aroma / bitter"
        case bitter = "bitter"
        case bitterAlternative = "Bitter"
        case bittering = "Bittering"
        case flavour = "flavour"
        case flavourAlternative = "Flavour"
    }
}


