//
//  BreweryListItemTableViewCell.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 12.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class BreweryListItemTableViewCell: UITableViewCell {
    private let horizontalSpacing: CGFloat = 20
    private let verticalSpacing: CGFloat = 10
    
    private var contentContainerView = ContainerView(cornerRadius: 5)
    private var logoImageView = UIImageView()
    private var nameLabel = BaseCellTitleLabel()
    private var establishmentDateLabel = BaseCellSubtitleLabel()
    private var tagsStackView = UIStackView()
    
    var item: Brewery? {
        didSet { refresh() }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder:) is not supported")
    }
    
    private func refresh() {
        nameLabel.text = item?.name
        establishmentDateLabel.text = item?.established
        setTags(for: item)
        logoImageView.loadCircularImage(from: item?.images?.medium)
    }
    
    private func setTags(for brewery: Brewery?) {
        tagsStackView.removeAllArrangedSubviews()
        
        let tags = [
            (canBeAdded: brewery?.isInBusiness, title: R.string.localizable.breweryListItemTagInBusiness(), color: UIColor.systemBlue),
            (canBeAdded: brewery?.isOrganic, title: R.string.localizable.breweryListItemTagOrganic(), color: UIColor.systemGreen),
            (canBeAdded: brewery?.isVerified, title: R.string.localizable.breweryListItemTagVerified(), color: UIColor.systemOrange)
        ]
        
        tags
            .filter { $0.canBeAdded == true }
            .forEach { (_, title, color) in
                let tagView = TagView(title: title, color: color)
                tagsStackView.addArrangedSubview(tagView)
                
                tagView.snp.makeConstraints { (make) in
                    make.height.equalTo(20)
                    make.top.bottom.equalToSuperview()
                }
            }
    }
}

extension BreweryListItemTableViewCell {
    private func setUp() {
        selectionStyle = .none
        setUpContentContainerView()
        setUpLogoImageView()
        setUpNameLabel()
        setUpEstablishmentDateLabel()
        setUpTagsStackView()
    }
    
    private func setUpContentContainerView() {
        addSubview(contentContainerView)
        
        contentContainerView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(horizontalSpacing)
            make.top.equalToSuperview().offset(verticalSpacing)
            make.right.equalToSuperview().inset(horizontalSpacing)
            make.bottom.equalToSuperview().inset(verticalSpacing)
        }
    }
    
    private func setUpLogoImageView() {
        contentContainerView.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(horizontalSpacing)
            make.top.equalToSuperview().offset(verticalSpacing)
            make.width.height.equalTo(60)
        }
    }
    
    private func setUpNameLabel() {
        contentContainerView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(logoImageView.snp.right).offset(horizontalSpacing * 0.5)
            make.top.equalTo(logoImageView).offset(verticalSpacing * 0.5)
            make.right.equalToSuperview().inset(horizontalSpacing)
        }
    }
    
    private func setUpEstablishmentDateLabel() {
        contentContainerView.addSubview(establishmentDateLabel)
         
        establishmentDateLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(verticalSpacing * 0.25)
        }
    }
    
    private func setUpTagsStackView() {
        tagsStackView.axis = .horizontal
        tagsStackView.spacing = horizontalSpacing * 0.5
        contentContainerView.addSubview(tagsStackView)
        
        tagsStackView.snp.makeConstraints { (make) in
            make.left.equalTo(logoImageView)
            make.top.equalTo(logoImageView.snp.bottom).offset(verticalSpacing * 0.75)
            make.right.lessThanOrEqualTo(nameLabel)
            make.width.equalTo(0).priority(.low)
            make.bottom.equalToSuperview().inset(verticalSpacing)
        }
    }
}
