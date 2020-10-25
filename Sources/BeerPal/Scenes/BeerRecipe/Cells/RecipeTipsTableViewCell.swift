//
//  RecipeTipsTableViewCell.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 23.10.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class RecipeTipsTableViewCell: UITableViewCell {
    private let horizontalSpacing: CGFloat = 30
    private let verticalSpacing: CGFloat = 10
    
    private let tipsLabel = ExtendableLabel()
    private let contributorLabel = ExtendableLabel()
    
    var tips: String? {
        didSet { tipsLabel.text = tips }
    }
    
    var contributor: String? {
        didSet { contributorLabel.text = contributor }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
}

extension RecipeTipsTableViewCell {
    private func setUp() {
        setUpTipsLabel()
        setUpContributorLabel()
    }
    
    private func setUpTipsLabel() {
        tipsLabel.textColor = Theme.Colors.Texts.primary
        tipsLabel.font = .italicSystemFont(ofSize: 15)
        addSubview(tipsLabel)
        
        tipsLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(verticalSpacing)
            make.left.equalToSuperview().offset(horizontalSpacing)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
    }
    
    private func setUpContributorLabel() {
        contributorLabel.textColor = Theme.Colors.Components.primary
        contributorLabel.font = .italicSystemFont(ofSize: 15)
        contributorLabel.textAlignment = .right
        addSubview(contributorLabel)
        
        contributorLabel.snp.makeConstraints { (make) in
            make.centerX.width.equalTo(tipsLabel)
            make.top.equalTo(tipsLabel.snp.bottom).offset(5)
            make.bottom.equalToSuperview().inset(verticalSpacing)
        }
    }
}
