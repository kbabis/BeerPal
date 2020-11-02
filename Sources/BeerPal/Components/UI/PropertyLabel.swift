//
//  PropertyLabel.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 01.11.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

class PropertyLabel: ExtendableLabel {
    override func setUp() {
        super.setUp()
        font = Theme.Fonts.getFont(ofSize: .small, weight: .medium)
    }
}
