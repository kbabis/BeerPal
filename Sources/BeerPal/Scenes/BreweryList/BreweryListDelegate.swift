//
//  BreweryListDelegate.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 30.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

protocol BreweryListDelegate: class {
    func didSelect(_ brewery: Brewery)
}
