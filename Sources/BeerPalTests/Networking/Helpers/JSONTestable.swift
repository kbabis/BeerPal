//
//  JSONTestable.swift
//  BeerPalTests
//
//  Created by Krzysztof Babis on 28.08.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

protocol JSONTestable {
    init?(_ json: String)
    
    func encodeJson() -> Data?
    func encodeJsonString() -> String?
}

extension JSONTestable where Self: Codable {
    init?(_ json: String) {
        guard
            let data = json.data(using: .utf8),
            let decoded = try? JSONDecoder().decode(Self.self, from: data)
        else { return nil }
        
        self = decoded
    }

    func encodeJson() -> Data? {
        return try? JSONEncoder().encode(self)
    }
    
    func encodeJsonString() -> String? {
        guard let data = encodeJson() else { return nil }
        
        return String(data: data, encoding: .utf8)
    }
}
