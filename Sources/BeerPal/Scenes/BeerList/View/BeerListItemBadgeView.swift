//
//  BeerListItemBadgeView.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 31.10.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class BeerListItemBadgeView: UIView {
    private let horizontalSpacing: CGFloat = 5.0
    private let verticalSpacing: CGFloat = 3.0
    
    private let nameLabel = BadgeNameLabel()
    private let valueLabel = BadgeValueLabel()
    
    var name: String? {
        didSet { nameLabel.text = name }
    }
    
    var value: String? {
        didSet { valueLabel.text = value }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
}

extension BeerListItemBadgeView {
    private func setUp() {
        layer.cornerRadius = 5.0
        backgroundColor = Theme.Colors.Components.primary
        setUpNameLabel()
        setUpValueLabel()
    }
    
    private func setUpNameLabel() {
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(horizontalSpacing)
            make.top.equalToSuperview().offset(verticalSpacing)
            make.right.equalToSuperview().inset(horizontalSpacing)
        }
    }
    
    private func setUpValueLabel() {
        addSubview(valueLabel)
        valueLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(verticalSpacing * 0.5)
            make.bottom.equalToSuperview().inset(verticalSpacing)
        }
    }
}

private class BadgeNameLabel: BaseLabel {
    override func setUp() {
        super.setUp()
        textAlignment = .center
        textColor = .black
        font = Theme.Fonts.getFont(ofSize: .xxSmall, weight: .bold)
    }
}

private class BadgeValueLabel: BadgeNameLabel {
    override func setUp() {
        super.setUp()
        font = Theme.Fonts.getFont(ofSize: .small, weight: .bold)
    }
}
