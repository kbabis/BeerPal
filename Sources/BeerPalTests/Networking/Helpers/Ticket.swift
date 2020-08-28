//
//  Ticket.swift
//  BeerPalTests
//
//  Created by Krzysztof Babis on 28.08.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

struct Ticket: Codable {
    let id: String
    let name: String
}

extension Ticket: Equatable {
    static func == (lhs: Ticket, rhs: Ticket) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Ticket: JSONTestable {}
