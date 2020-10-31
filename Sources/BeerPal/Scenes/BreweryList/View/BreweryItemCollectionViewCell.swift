//BreweryItemCollectionViewCell//  BreweryListItemTableViewCell.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 12.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class BreweryItemCollectionViewCell: UICollectionViewCell {
    private let horizontalSpacing: CGFloat = 10
    private let verticalSpacing: CGFloat = 10
    
    private let logoImageView = UIImageView()
    private let contentContainerView = UIView()
    private let arrowIndicatorImageView = UIImageView()
    private let nameLabel = BaseCellTitleLabel()
    private let descriptionLabel = BaseCellSubtitleLabel()
    private let tagsStackView = UIStackView()
    
    var item: Brewery? {
        didSet { refresh() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    private func refresh() {
        nameLabel.text = item?.name
        descriptionLabel.text = item?.description
        logoImageView.loadImage(from: item?.images?.large)
    }
}

extension BreweryItemCollectionViewCell {
    private func setUp() {
        layer.masksToBounds = true
        backgroundColor = Theme.Colors.Background.container
        layer.cornerRadius = 5
        
        setUpLogoImageView()
        setUpContentContainerView()
        setUpArrowIndicatorImageView()
        setUpNameLabel()
        setUpDescriptionLabel()
    }
    
    private func setUpLogoImageView() {
        logoImageView.contentMode = .scaleAspectFill
        addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.45)
        }
    }
    
    private func setUpContentContainerView() {
        addSubview(contentContainerView)
        
        contentContainerView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(logoImageView.snp.bottom)
        }
    }
    
    private func setUpArrowIndicatorImageView() {
        arrowIndicatorImageView.image = R.image.arrowIndicator()?.withRenderingMode(.alwaysTemplate)
        arrowIndicatorImageView.tintColor = Theme.Colors.Components.primary
        contentContainerView.addSubview(arrowIndicatorImageView)
        
        arrowIndicatorImageView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(horizontalSpacing)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(12)
        }
    }
    
    private func setUpNameLabel() {
        nameLabel.font = Theme.Fonts.getFont(ofSize: .medium, weight: .semibold)
        contentContainerView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(horizontalSpacing)
            make.top.equalToSuperview().offset(verticalSpacing)
            make.right.equalTo(arrowIndicatorImageView.snp.left)
        }
    }
    
    private func setUpDescriptionLabel() {
        descriptionLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        descriptionLabel.lineBreakMode = .byTruncatingTail
        contentContainerView.addSubview(descriptionLabel)
         
        descriptionLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(verticalSpacing * 0.25)
            make.bottom.equalToSuperview().inset(verticalSpacing)
        }
    }
}
