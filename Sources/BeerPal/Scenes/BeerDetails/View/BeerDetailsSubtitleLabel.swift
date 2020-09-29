//
//  BeerDetailsSubtitleLabel.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 28.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class BeerDetailsSubtitleLabel: ExtendableLabel {
    override func setUp() {
        super.setUp()
        font = .italicSystemFont(ofSize: 17.0)
        textColor = Theme.Colors.Texts.secondary
    }
}
