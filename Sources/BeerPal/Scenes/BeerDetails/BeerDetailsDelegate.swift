//
//  BeerDetailsDelegate.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 24.10.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

protocol BeerDetailsDelegate: class {
    func showRecipe(of beer: Beer)
}
