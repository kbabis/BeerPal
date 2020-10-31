//
//  BeerListItemTableViewCell.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 22.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class BeerListItemTableViewCell: UITableViewCell {
    private let horizontalSpacing: CGFloat = 20
    private let verticalSpacing: CGFloat = 10
    
    private let contentContainerView = ContainerView(cornerRadius: 5)
    private let beerImageView = UIImageView()
    private let nameLabel = BaseCellTitleLabel()
    private let descriptionLabel = BaseCellSubtitleLabel()
    private let firstBrewedYearLabel = BaseCellSubtitleLabel()
    private let alcoholByVolumeBadgeView = BeerListItemBadgeView()
    private let ibuBadgeView = BeerListItemBadgeView()
    
    var item: BeerListItemViewModel? {
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
        guard let beer = item else { return }
        
        nameLabel.text = beer.name
        descriptionLabel.text = beer.description
        firstBrewedYearLabel.text = beer.firstBrewedYear
        beerImageView.loadImage(from: beer.imageURLString, estimatedSize: .init(width: 40, height: 120))
        alcoholByVolumeBadgeView.name = beer.abvName
        alcoholByVolumeBadgeView.value = beer.abvValue
        ibuBadgeView.name = beer.ibuName
        ibuBadgeView.value = beer.ibuValue
        ibuBadgeView.isHidden = (beer.ibuValue == nil)
    }
}

extension BeerListItemTableViewCell {
    private func setUp() {
        selectionStyle = .none
        setUpContentContainerView()
        setUpBeerImageView()
        setUpAlcoholByVolumeBadgeView()
        setUpIbuBadgeView()
        setUpFirstBrewedYearLabel()
        setUpDescriptionLabel()
        setUpNameLabel()
    }
    
    private func setUpContentContainerView() {
        addSubview(contentContainerView)
        
        contentContainerView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(horizontalSpacing)
            make.right.equalToSuperview().inset(horizontalSpacing)
            make.bottom.equalToSuperview().inset(verticalSpacing)
        }
    }
    
    private func setUpBeerImageView() {
        beerImageView.contentMode = .scaleAspectFit
        addSubview(beerImageView)
        
        beerImageView.snp.makeConstraints { (make) in
            make.left.equalTo(contentContainerView).offset(horizontalSpacing)
            make.top.equalToSuperview().offset(verticalSpacing)
            make.width.equalTo(40)
            make.height.equalTo(110)
            make.bottom.equalTo(contentContainerView).inset(verticalSpacing)
        }
    }
    
    private func setUpAlcoholByVolumeBadgeView() {
        contentContainerView.addSubview(alcoholByVolumeBadgeView)

        alcoholByVolumeBadgeView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(5)
            make.bottom.equalTo(contentContainerView).offset(5)
            make.width.greaterThanOrEqualTo(35)
        }
    }
    
    private func setUpIbuBadgeView() {
        contentContainerView.addSubview(ibuBadgeView)

        ibuBadgeView.snp.makeConstraints { (make) in
            make.right.equalTo(alcoholByVolumeBadgeView.snp.left).offset(-5)
            make.bottom.equalTo(alcoholByVolumeBadgeView)
            make.width.greaterThanOrEqualTo(35)
        }
    }
    
    private func setUpFirstBrewedYearLabel() {
        contentContainerView.addSubview(firstBrewedYearLabel)
         
        firstBrewedYearLabel.snp.makeConstraints { (make) in
            make.left.equalTo(beerImageView.snp.right).offset(horizontalSpacing)
            make.right.equalTo(ibuBadgeView.snp.left).offset(-5)
            make.bottom.equalToSuperview().inset(verticalSpacing)
        }
    }
    
    private func setUpDescriptionLabel() {
        contentContainerView.addSubview(descriptionLabel)
         
        descriptionLabel.snp.makeConstraints { (make) in
            make.left.equalTo(firstBrewedYearLabel)
            make.right.equalToSuperview().inset(horizontalSpacing)
            make.bottom.equalTo(firstBrewedYearLabel.snp.top).offset(-verticalSpacing * 0.5)
        }
    }
    
    private func setUpNameLabel() {
        contentContainerView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(descriptionLabel)
            make.top.equalToSuperview().offset(verticalSpacing)
            make.right.equalToSuperview().inset(horizontalSpacing)
            make.bottom.equalTo(descriptionLabel.snp.top).offset(-verticalSpacing * 0.5)
        }
    }
}
