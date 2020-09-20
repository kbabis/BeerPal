//
//  BaseLabel.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 07.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

class BaseLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    func setUp() {
        textColor = Theme.Colors.Texts.primary
    }
}
