//
//  EventDetailsView.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 20.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class EventDetailsView: UIView {
    private let horizontalSpacing: CGFloat = 20
    private let verticalSpacing: CGFloat = 10
    
    private let scrollView = UIScrollView()
    private let mapView = MapView()
    private let contentContainerView = UIView()
    private let logoImageView = UIImageView()
    private let nameLabel = NameLabel()
    private let dateField = DetailsFieldView()
    private let addressField = DetailsFieldView()
    private let fieldsStackView = UIStackView()
    private let descriptionLabel = ExtendableLabel()
    
    init(using event: EventDetailsViewModel, frame: CGRect = .zero) {
        super.init(frame: frame)
        setUp()
        fill(with: event)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    private func fill(with event: EventDetailsViewModel) {
        nameLabel.text = event.name
        dateField.set(text: event.dateInfo, icon: R.image.tabEvent())
        addressField.set(text: event.fullAddress, icon: R.image.location())
        descriptionLabel.text = event.description
        logoImageView.loadImage(from: event.imageURLString)
        mapView.setFocusPoint(latitude: event.coordinates.latitude, longitude: event.coordinates.longitude)
        
        if let price = event.priceFormatted {
            let priceField = DetailsFieldView(text: price, icon: R.image.price())
            fieldsStackView.addArrangedSubview(priceField)
        }
        
        if let phoneNumber = event.phoneNumber {
            let phoneField = DetailsFieldView(text: phoneNumber, icon: R.image.phone())
            fieldsStackView.addArrangedSubview(phoneField)
        }
        
        if let url = event.websiteURL {
            if #available(iOS 13.0, *) {
                let websiteRichLinkView = RichLinkView()
                websiteRichLinkView.loadURL(url)
                fieldsStackView.addArrangedSubview(websiteRichLinkView)
            } else {
                let websiteField = DetailsFieldView(text: url.absoluteString, icon: R.image.link())
                fieldsStackView.addArrangedSubview(websiteField)
            }
        }
    }
}

extension EventDetailsView {
    private func setUp() {
        backgroundColor = .systemBlue
        setUpScrollView()
        setUpContentContainerView()
        setUpMapView()
        setUpLogoImageView()
        setUpNameLabel()
        setUpDateField()
        setUpAddressField()
        setUpFieldsStackView()
        setUpDescriptionLabel()
    }
    
    private func setUpScrollView() {
        addSubview(scrollView)
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func setUpContentContainerView() {
        scrollView.addSubview(contentContainerView)
        
        contentContainerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(200)
            make.width.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func setUpMapView() {
        scrollView.insertSubview(mapView, belowSubview: contentContainerView)
        
        mapView.snp.makeConstraints { [weak self] (make) in
            guard let self = self else { return }
            
            make.left.top.right.equalTo(self)
            make.bottom.equalTo(contentContainerView.snp.top).priority(.high)
        }
    }
    
    private func setUpLogoImageView() {
        let size: CGFloat = 100
        contentContainerView.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(-size * 0.5)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(size)
        }
    }
    
    private func setUpNameLabel() {
        contentContainerView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(horizontalSpacing)
            make.top.equalTo(logoImageView.snp.bottom).offset(verticalSpacing)
            make.right.equalToSuperview().inset(horizontalSpacing)
        }
    }
    
    
    private func setUpDateField() {
        contentContainerView.addSubview(dateField)
        
        dateField.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(verticalSpacing)
            make.left.right.equalTo(nameLabel)
        }
    }
    
    private func setUpAddressField() {
        contentContainerView.addSubview(addressField)
        
        addressField.snp.makeConstraints { (make) in
            make.top.equalTo(dateField.snp.bottom).offset(verticalSpacing)
            make.left.right.equalTo(dateField)
        }
    }
    
    private func setUpFieldsStackView() {
        fieldsStackView.axis = .vertical
        fieldsStackView.distribution = .equalSpacing
        fieldsStackView.spacing = verticalSpacing
        contentContainerView.addSubview(fieldsStackView)
        
        fieldsStackView.snp.makeConstraints { (make) in
            make.top.equalTo(addressField.snp.bottom)
            make.left.right.equalTo(addressField)
        }
    }
    
    private func setUpDescriptionLabel() {
        contentContainerView.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(fieldsStackView.snp.bottom).offset(verticalSpacing)
            make.left.right.equalTo(fieldsStackView)
            make.bottom.equalToSuperview().inset(verticalSpacing)
        }
    }
}

extension EventDetailsView {
    class NameLabel: ExtendableLabel {
        override func setUp() {
            super.setUp()
            font = Theme.Fonts.getFont(ofSize: .xLarge, weight: .bold)
            textAlignment = .center
        }
    }
}

