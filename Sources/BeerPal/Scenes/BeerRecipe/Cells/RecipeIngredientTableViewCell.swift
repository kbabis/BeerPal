//
//  RecipeIngredientTableViewCell.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 23.10.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class RecipeIngredientTableViewCell: UITableViewCell {
    private let horizontalSpacing: CGFloat = 30
    private let verticalSpacing: CGFloat = 10
    
    private var nameLabel = BaseCellTitleLabel()
    
    var name: String? {
        didSet { nameLabel.text = name }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpNameLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpNameLabel()
    }
}

extension RecipeIngredientTableViewCell {
    private func setUpNameLabel() {
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(horizontalSpacing)
            make.top.equalToSuperview().offset(verticalSpacing)
            make.right.equalToSuperview().inset(horizontalSpacing)
            make.bottom.equalToSuperview().inset(verticalSpacing)
        }
    }
}
