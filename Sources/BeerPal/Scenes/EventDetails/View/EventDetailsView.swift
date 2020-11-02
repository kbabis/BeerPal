//
//  EventDetailsView.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 20.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class EventDetailsView: UIView {
    private let horizontalSpacing: CGFloat = 30
    private let verticalSpacing: CGFloat = 24
    
    private let scrollView = UIScrollView()
    private let contentContainerView = UIView()
    private let logoImageView = UIImageView()
    private let nameLabel = NameLabel()
    private let dateField = DetailsFieldView()
    private let fieldsStackView = UIStackView()
    private let descriptionHeaderLabel = HeaderLabel()
    private let descriptionContentLabel = ExtendableLabel()
    private(set) var phoneField: InteractiveDetailsFieldView?
    let addressField = InteractiveDetailsFieldView()
    let mapView = MapView()
    
    init(using event: EventDetailsItemViewModel, frame: CGRect = .zero) {
        super.init(frame: frame)
        setUp()
        fill(with: event)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    private func fill(with event: EventDetailsItemViewModel) {
        nameLabel.text = event.name
        dateField.set(text: event.dateInfo, icon: "📅")
        addressField.set(text: event.fullAddress, icon: "🏠")
        descriptionContentLabel.text = event.description
        logoImageView.loadCircularImage(from: event.imageURLString, estimatedSize: .init(width: 100, height: 100))
        mapView.setFocusPoint(latitude: event.coordinates.latitude, longitude: event.coordinates.longitude)
        
        if let price = event.priceFormatted {
            let priceLabel = DetailsFieldView(text: price, icon: "💸")
            fieldsStackView.addArrangedSubview(priceLabel)
        }
        
        if let phoneNumber = event.phoneNumber {
            phoneField = InteractiveDetailsFieldView(text: phoneNumber, icon: "☎️")
            fieldsStackView.addArrangedSubview(phoneField!)
        }
        
        if let url = event.websiteURL {
            if #available(iOS 13.0, *) {
                let websiteRichLinkView = RichLinkView()
                websiteRichLinkView.loadURL(url)
                fieldsStackView.addArrangedSubview(websiteRichLinkView)
            } else {
                let websiteField = DetailsFieldView(text: url.absoluteString, icon: "🌐")
                fieldsStackView.addArrangedSubview(websiteField)
            }
        }
    }
}

extension EventDetailsView {
    private func setUp() {
        backgroundColor = Theme.Colors.Background.primary
        setUpScrollView()
        setUpContentContainerView()
        setUpMapView()
        setUpLogoImageView()
        setUpNameLabel()
        setUpDateField()
        setUpAddressField()
        setUpFieldsStackView()
        setUpDescriptionHeaderLabel()
        setUpDescriptionContentLabel()
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
            make.left.top.right.bottom.width.equalToSuperview()
        }
    }
    
    private func setUpMapView() {
        contentContainerView.addSubview(mapView)
         
        mapView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(400)
        }
    }
    
    private func setUpLogoImageView() {
        let size: CGFloat = 100
        contentContainerView.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(mapView.snp.bottom).offset(-size * 0.5)
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
            make.top.equalTo(dateField.snp.bottom).offset(verticalSpacing * 0.5)
            make.left.right.equalTo(dateField)
        }
    }
    
    private func setUpFieldsStackView() {
        fieldsStackView.axis = .vertical
        fieldsStackView.spacing = verticalSpacing * 0.5
        contentContainerView.addSubview(fieldsStackView)
        
        fieldsStackView.snp.makeConstraints { (make) in
            make.top.equalTo(addressField.snp.bottom).offset(verticalSpacing * 0.5)
            make.left.right.equalTo(addressField)
        }
    }
    
    private func setUpDescriptionHeaderLabel() {
        descriptionHeaderLabel.text = R.string.localizable.eventDetailsDescriptionHeader()
        contentContainerView.addSubview(descriptionHeaderLabel)
        descriptionHeaderLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.top.equalTo(fieldsStackView.snp.bottom).offset(verticalSpacing * 1.5)
            make.right.equalToSuperview().inset(horizontalSpacing)
        }
    }
    
    private func setUpDescriptionContentLabel() {
        contentContainerView.addSubview(descriptionContentLabel)
        
        descriptionContentLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(descriptionHeaderLabel)
            make.top.equalTo(descriptionHeaderLabel.snp.bottom).offset(verticalSpacing * 0.6)
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

