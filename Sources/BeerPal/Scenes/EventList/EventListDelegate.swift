//
//  EventListDelegate.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 20.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

protocol EventListDelegate: class {
    func didSelect(_ event: Event)
}
