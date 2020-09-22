//
//  ContainerView.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 23.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

class ContainerView: UIView {
    convenience init(color: UIColor = Theme.Colors.Background.container, cornerRadius: CGFloat) {
        self.init()
        backgroundColor = color
        layer.cornerRadius = 5
    }
}
