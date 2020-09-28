//
//  HeaderLabel.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 28.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

final class HeaderLabel: ExtendableLabel {
    override func setUp() {
        super.setUp()
        font = Theme.Fonts.getFont(ofSize: .large, weight: .bold)
        textColor = Theme.Colors.Texts.primary
    }
}
