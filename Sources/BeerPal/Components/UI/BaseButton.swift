//
//  BaseButton.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 07.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

class BaseButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height * 0.5
    }
    
    func setUp() {
        backgroundColor = Theme.Colors.Components.background
        setTitleColor(Theme.Colors.Components.foreground, for: .normal)
    }
}
