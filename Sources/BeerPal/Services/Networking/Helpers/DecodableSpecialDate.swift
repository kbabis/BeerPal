//
//  DecodableSpecialDate.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 19.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

@propertyWrapper
struct DecodableSpecialDate: Codable {
    let wrappedValue: Date?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-DD"
        wrappedValue = formatter.date(from: rawValue)
    }
}
