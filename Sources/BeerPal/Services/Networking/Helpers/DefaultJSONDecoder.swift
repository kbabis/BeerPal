//
//  DefaultJSONDecoder.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 10.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

final class DefaultJSONDecoder: JSONDecoder {
    override init() {
        super.init()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD HH:mm:ss"
        dateDecodingStrategy = .formatted(dateFormatter)
    }
}
