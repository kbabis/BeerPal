//
//  BreweryDetailsItemViewModel.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 30.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

final class BreweryDetailsItemViewModel {
    private let brewery: Brewery
    
    var name: String { brewery.name }
    var imageURLString: String? { brewery.images?.large }
    var inBusiness: String? { brewery.isInBusiness.textIfTrue("💰 Still in business") }
    var verified: String? { brewery.isVerified.textIfTrue("✅ Verified") }
    var organic: String? { brewery.isOrganic.textIfTrue("🌿 Organic") }
    var description: String? { brewery.description }
    var websiteURL: URL? { brewery.website?.urlValue }
    
    init(from brewery: Brewery) {
        self.brewery = brewery
    }
}

private extension Bool {
    func textIfTrue(_ text: String) -> String? {
        return self ? text : nil
    }
}

private extension String {
    var urlValue: URL? {
        return URL(string: self)
    }
}
