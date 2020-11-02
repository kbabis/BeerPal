//
//  EventListItemTableViewCell.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 19.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class EventListItemTableViewCell: UITableViewCell {
    private let horizontalSpacing: CGFloat = 20
    private let verticalSpacing: CGFloat = 10
    
    private var dateLabel = BaseCellSubtitleLabel()
    private var typeLabel = BaseCellSubtitleLabel()
    private var contentContainerView = ContainerView(cornerRadius: 5)
    private var logoImageView = UIImageView()
    private var nameLabel = BaseCellTitleLabel()
    private var addressLabel = BaseCellSubtitleLabel()
    
    var item: EventListItemViewModel? {
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
        guard let event = item else { return }
        
        dateLabel.text = event.date
        nameLabel.text = event.name
        addressLabel.text = event.address
        typeLabel.text = event.type

        logoImageView.loadCircularImage(from: event.imageURLString)
    }
}

extension EventListItemTableViewCell {
    private func setUp() {
        selectionStyle = .none
        setUpDateLabel()
        setUpTypeLabel()
        setUpContentContainerView()
        setUpLogoImageView()
        setUpNameLabel()
        setUpAddressLabel()
    }
    
    private func setUpDateLabel() {
        dateLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(horizontalSpacing)
            make.top.equalToSuperview().offset(verticalSpacing)
        }
    }
    
    private func setUpTypeLabel() {
        typeLabel.textAlignment = .right
        typeLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        addSubview(typeLabel)
        
        typeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(dateLabel.snp.right).offset(horizontalSpacing * 0.5)
            make.top.equalTo(dateLabel)
            make.right.equalToSuperview().inset(horizontalSpacing)
        }
    }
    
    private func setUpContentContainerView() {
        addSubview(contentContainerView)
        
        contentContainerView.snp.makeConstraints { (make) in
            make.left.equalTo(dateLabel)
            make.top.equalTo(dateLabel.snp.bottom).offset(verticalSpacing * 0.4)
            make.right.equalTo(typeLabel)
            make.bottom.equalToSuperview().inset(verticalSpacing * 2)
        }
    }
    
    private func setUpLogoImageView() {
        contentContainerView.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(horizontalSpacing * 0.5)
            make.top.equalToSuperview().offset(verticalSpacing)
            make.width.height.equalTo(55)
            make.bottom.lessThanOrEqualToSuperview().inset(verticalSpacing)
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
    
    private func setUpAddressLabel() {
        contentContainerView.addSubview(addressLabel)
         
        addressLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(verticalSpacing * 0.25)
            make.bottom.equalToSuperview().inset(verticalSpacing).priority(.medium)
        }
    }
}
