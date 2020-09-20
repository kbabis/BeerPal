//
//  ExtendableLabel.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 17.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

class ExtendableLabel: BaseLabel {
    override func setUp() {
        super.setUp()
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
    }
}
