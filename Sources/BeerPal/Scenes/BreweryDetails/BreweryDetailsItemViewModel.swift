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
    var type: String? { brewery.locations.first?.locationTypeDisplay.withPrefix("🏪 ") }
    var inBusiness: String? { brewery.isInBusiness.textIfTrue("💰 " + R.string.localizable.breweryDetailsPropertyBusiness()) }
    var verified: String? { brewery.isVerified.textIfTrue("✅ " + R.string.localizable.breweryDetailsPropertyVerified()) }
    var organic: String? { brewery.isOrganic.textIfTrue("🌿 " + R.string.localizable.breweryDetailsPropertyOrganic()) }
    var description: String? { brewery.description }
    var address: String? { makeFullAddress(for: brewery)?.withPrefix("🏠 ") }
    var phoneNumber: String? { brewery.locations.first?.phone?.withPrefix("☎️ ") }
    var websiteURL: URL? { brewery.website?.urlValue }
    
    init(from brewery: Brewery) {
        self.brewery = brewery
    }
    
    private func makeFullAddress(for brewery: Brewery) -> String? {
        guard let location = brewery.locations.first else { return nil }
        
        return [location.streetAddress, location.postalCode, location.locality, location.region]
            .reduce("", { $0 == "" ? $1 : $0 + ", " + $1 })
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
    
    func withPrefix(_ prefix: String) -> String {
        return prefix + self
    }
}
