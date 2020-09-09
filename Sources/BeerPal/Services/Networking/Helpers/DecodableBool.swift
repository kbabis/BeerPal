//
//  DecodableBool.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 10.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

@propertyWrapper
struct DecodableBool: Codable {
    let wrappedValue: Bool
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        wrappedValue = rawValue.lowercased() == "y"
    }
}
