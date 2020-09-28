//
//  BeerDetailsView.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 24.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class BeerDetailsView: UIView {
    private let horizontalSpacing: CGFloat = 30.0
    private let verticalSpacing: CGFloat = 20.0
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let nameLabel = BeerDetailsTitleLabel()
    private let taglineLabel = BeerDetailsSubtitleLabel()
    private let backgroundImageView = UIImageView()
    private let beerImageView = UIImageView()
    private let alcoholByVolumeView = BeerPropertyView()
    private let gravityView = BeerPropertyView()
    private let bitternessView = BeerPropertyView()
    private let colorView = BeerPropertyView()
    private let descriptionHeaderLabel = HeaderLabel()
    private let descriptionLabel = BeerDetailsDescriptionLabel()
    private let brewageHeaderLabel = HeaderLabel()
    private let brewageTipsLabel = BeerDetailsDescriptionLabel()
    private let contributorLabel = BeerDetailsContributorLabel()
    
    init(using beer: BeerDetailsItemViewModel, frame: CGRect = .zero) {
        super.init(frame: frame)
        setUp()
        fill(with: beer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    private func fill(with beer: BeerDetailsItemViewModel) {
        nameLabel.text = beer.name
        taglineLabel.text = beer.tagline
        beerImageView.loadImage(from: beer.imageURL)
        alcoholByVolumeView.value = beer.abv
        gravityView.value = beer.gravity
        bitternessView.value = beer.bitterness
        colorView.value = beer.ebc
        //colorView.image = .image(from: color(for: beer.ebc))
        descriptionLabel.text = beer.description
        brewageTipsLabel.text = beer.tips
        contributorLabel.text = beer.contributor
    }
}

extension BeerDetailsView {
    private func setUp() {
        backgroundColor = Theme.Colors.Background.primary
        setUpScrollView()
        setUpContentView()
        setUpBeerImageView()
        setUpBackgroundImageView()
        setUpNameLabel()
        setUpTaglineLabel()
        setUpAlcoholByVolumeView()
        setUpGravityView()
        setUpBitternessView()
        setUpColorView()
        setUpDescriptionHeaderLabel()
        setUpDescriptionLabel()
        setUpBrewageHeaderLabel()
        setUpBrewageTipsLabel()
        setUpContributorLabel()
    }
    
    private func setUpScrollView() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func setUpContentView() {
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.width.equalToSuperview()
        }
    }
    
    private func setUpBeerImageView() {
        beerImageView.contentMode = .scaleAspectFit
        contentView.addSubview(beerImageView)
        beerImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(verticalSpacing)
            make.right.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.44)
            make.height.equalTo(beerImageView.snp.width).multipliedBy(2.5)
        }
    }
    
    private func setUpBackgroundImageView() {
        backgroundImageView.image = R.image.pxLACMTA_Circle_Gold_LineSvg()
        contentView.insertSubview(backgroundImageView, belowSubview: beerImageView)
        backgroundImageView.snp.makeConstraints { (make) in
            make.bottom.right.equalTo(beerImageView)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(beerImageView).multipliedBy(0.66)
        }
    }
    
    private func setUpNameLabel() {
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(horizontalSpacing)
            make.top.equalToSuperview().offset(verticalSpacing)
            make.width.equalToSuperview().multipliedBy(0.6)
        }
    }
    
    private func setUpTaglineLabel() {
        contentView.addSubview(taglineLabel)
        taglineLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(verticalSpacing * 0.4)
        }
    }
    
    private func setUpAlcoholByVolumeView() {
        alcoholByVolumeView.image = R.image.beerDetailsPercent()
        alcoholByVolumeView.name = R.string.localizable.beerDetailsPropertyNameAbv()
        contentView.addSubview(alcoholByVolumeView)
        alcoholByVolumeView.snp.makeConstraints { (make) in
            make.left.equalTo(taglineLabel)
            make.top.equalTo(taglineLabel.snp.bottom).offset(verticalSpacing * 1.5)
            make.right.equalTo(backgroundImageView.snp.left)
        }
    }
    
    private func setUpGravityView() {
        gravityView.image = R.image.beerDetailsGravity()
        gravityView.name = R.string.localizable.beerDetailsPropertyNameGravity()
        contentView.addSubview(gravityView)
        gravityView.snp.makeConstraints { (make) in
            make.left.right.equalTo(alcoholByVolumeView)
            make.top.equalTo(alcoholByVolumeView.snp.bottom).offset(verticalSpacing * 0.75)
        }
    }
    
    private func setUpBitternessView() {
        bitternessView.image = R.image.beerDetailsHop()
        bitternessView.name = R.string.localizable.beerDetailsPropertyNameBitterness()
        contentView.addSubview(bitternessView)
        bitternessView.snp.makeConstraints { (make) in
            make.left.right.equalTo(gravityView)
            make.top.equalTo(gravityView.snp.bottom).offset(verticalSpacing * 0.75)
        }
    }
    
    private func setUpColorView() {
        colorView.image = R.image.beerDetailsHop()
        colorView.name = R.string.localizable.beerDetailsPropertyNameBitterness()
        contentView.addSubview(colorView)
        colorView.snp.makeConstraints { (make) in
            make.left.right.equalTo(bitternessView)
            make.top.equalTo(bitternessView.snp.bottom).offset(verticalSpacing * 0.75)
        }
    }
    
    private func setUpDescriptionHeaderLabel() {
        descriptionHeaderLabel.text = R.string.localizable.beerDetailsDescriptionHeader()
        contentView.addSubview(descriptionHeaderLabel)
        descriptionHeaderLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.top.equalTo(beerImageView.snp.bottom).offset(verticalSpacing * 0.25).priority(.medium)
            make.top.greaterThanOrEqualTo(colorView.snp.bottom).offset(verticalSpacing * 1.5)
            make.right.equalToSuperview().inset(horizontalSpacing)
        }
    }
    
    private func setUpDescriptionLabel() {
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(descriptionHeaderLabel)
            make.top.equalTo(descriptionHeaderLabel.snp.bottom).offset(verticalSpacing * 0.6)
        }
    }
    
    private func setUpBrewageHeaderLabel() {
        brewageHeaderLabel.text = R.string.localizable.beerDetailsBrewageHeader()
        contentView.addSubview(brewageHeaderLabel)
        brewageHeaderLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(descriptionHeaderLabel)
            make.top.greaterThanOrEqualTo(descriptionLabel.snp.bottom).offset(verticalSpacing * 1.5)
        }
    }
    
    private func setUpBrewageTipsLabel() {
        contentView.addSubview(brewageTipsLabel)
        brewageTipsLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(brewageHeaderLabel)
            make.top.equalTo(brewageHeaderLabel.snp.bottom).offset(verticalSpacing * 0.6)
        }
    }
    
    private func setUpContributorLabel() {
        contentView.addSubview(contributorLabel)
        contributorLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(brewageTipsLabel)
            make.top.equalTo(brewageTipsLabel.snp.bottom).offset(verticalSpacing * 0.2)
            make.bottom.equalToSuperview().inset(verticalSpacing)
        }
    }
}
