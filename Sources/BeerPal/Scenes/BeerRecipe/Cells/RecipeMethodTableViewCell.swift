//
//  RecipeMethodTableViewCell.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 23.10.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class RecipeMethodTableViewCell: UITableViewCell {
    private let horizontalSpacing: CGFloat = 30
    private let verticalSpacing: CGFloat = 10
    
    private var indexLabel = IndexLabel()
    private var nameLabel = BaseCellTitleLabel()
    
    var index: Int? {
        didSet { indexLabel.text = index?.stringValue }
    }
    
    var name: String? {
        didSet { nameLabel.text = name }
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

extension RecipeMethodTableViewCell {
    private func setUp() {
        setUpIndexLabel()
        setUpNameLabel()
    }
    
    private func setUpIndexLabel() {
        addSubview(indexLabel)
        
        indexLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(horizontalSpacing)
            make.top.equalToSuperview().offset(verticalSpacing)
            make.height.lessThanOrEqualTo(30).priority(.high)
            make.width.equalTo(indexLabel.snp.height)
            make.bottom.equalToSuperview().inset(verticalSpacing).priority(.medium)
        }
    }
    
    private func setUpNameLabel() {
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(indexLabel.snp.right).offset(horizontalSpacing * 0.5)
            make.top.equalTo(indexLabel)
            make.right.equalToSuperview().inset(horizontalSpacing)
            make.bottom.equalToSuperview().inset(verticalSpacing)
        }
    }
}

private class IndexLabel: BaseLabel {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width * 0.5
        layer.masksToBounds = true
    }
    
    override func setUp() {
        super.setUp()
        textColor = .black
        backgroundColor = Theme.Colors.Components.primary
        textAlignment = .center
        font = Theme.Fonts.getFont(ofSize: .small, weight: .bold)
        adjustsFontSizeToFitWidth = true
    }
}

private extension Int {
    var stringValue: String {
        return String(self)
    }
}
