//
//  BeerDetailsContributorLabel.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 28.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

final class BeerDetailsContributorLabel: ExtendableLabel {
    override func setUp() {
        super.setUp()
        textAlignment = .right
        font = .italicSystemFont(ofSize: 15)
        textColor = Theme.Colors.Components.background
    }
}
