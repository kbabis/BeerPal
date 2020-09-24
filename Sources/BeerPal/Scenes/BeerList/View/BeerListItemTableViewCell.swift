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
    private let tagsStackView = UIStackView()
    
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
        setTags(beer.tags)
        beerImageView.loadImage(from: beer.imageURLString, estimatedSize: .init(width: 40, height: 120))
    }
    
    private func setTags(_ tags: [EventListItemViewModel.Tag]) {
        tagsStackView.removeAllArrangedSubviews()
    
        tags.forEach { (title, color) in
            let tagView = TagView(title: title, color: color)
            tagsStackView.addArrangedSubview(tagView)
            
            tagView.snp.makeConstraints { (make) in
                make.height.equalTo(20)
                make.top.bottom.equalToSuperview()
            }
        }
    }
}

extension BeerListItemTableViewCell {
    private func setUp() {
        selectionStyle = .none
        setUpContentContainerView()
        setUpBeerImageView()
        setUpTagsStackView()
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
            make.top.equalToSuperview().offset(-verticalSpacing * 2)
            make.width.equalTo(40)
            make.height.equalTo(140)
            make.bottom.equalTo(contentContainerView).inset(verticalSpacing)
        }
    }
    
    private func setUpTagsStackView() {
        tagsStackView.axis = .horizontal
        tagsStackView.spacing = horizontalSpacing * 0.5
        contentContainerView.addSubview(tagsStackView)

        tagsStackView.snp.makeConstraints { (make) in
            make.left.equalTo(beerImageView.snp.right).offset(horizontalSpacing)
            make.right.lessThanOrEqualToSuperview().inset(horizontalSpacing)
            make.bottom.equalTo(contentContainerView).inset(verticalSpacing)
            make.width.equalTo(0).priority(.low)
        }
    }
    
    private func setUpFirstBrewedYearLabel() {
        contentContainerView.addSubview(firstBrewedYearLabel)
         
        firstBrewedYearLabel.snp.makeConstraints { (make) in
            make.left.equalTo(tagsStackView)
            make.right.equalToSuperview().inset(horizontalSpacing)
            make.bottom.equalTo(tagsStackView.snp.top).offset(-verticalSpacing * 0.5)
        }
    }
    
    private func setUpDescriptionLabel() {
        contentContainerView.addSubview(descriptionLabel)
         
        descriptionLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(firstBrewedYearLabel)
            make.bottom.equalTo(firstBrewedYearLabel.snp.top).offset(-verticalSpacing * 0.5)
        }
    }
    
    private func setUpNameLabel() {
        contentContainerView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(descriptionLabel)
            make.top.equalToSuperview().offset(verticalSpacing)
            make.bottom.equalTo(descriptionLabel.snp.top).offset(-verticalSpacing * 0.5)
        }
    }
}
