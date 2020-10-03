//
//  BeerDetailsTitleLabel.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 28.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

final class TitleLabel: ExtendableLabel {
    override func setUp() {
        super.setUp()
        font = Theme.Fonts.getFont(ofSize: .xxxLarge, weight: .heavy)
        textColor = Theme.Colors.Texts.primary
    }
}
