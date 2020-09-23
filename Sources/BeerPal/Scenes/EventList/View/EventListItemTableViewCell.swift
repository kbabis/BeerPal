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
    private var contentContainerView = ContainerView(cornerRadius: 5)
    private var logoImageView = UIImageView()
    private var nameLabel = BaseCellTitleLabel()
    private var addressLabel = BaseCellSubtitleLabel()
    private var tagsStackView = UIStackView()
    
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
        setTags(event.tags)
        logoImageView.loadCircularImage(from: event.imageURLString)
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

extension EventListItemTableViewCell {
    private func setUp() {
        selectionStyle = .none
        setUpDateLabel()
        setUpContentContainerView()
        setUpLogoImageView()
        setUpNameLabel()
        setUpAddressDateLabel()
        setUpTagsStackView()
    }
    
    private func setUpDateLabel() {
        addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(horizontalSpacing)
            make.top.equalToSuperview().offset(verticalSpacing)
            make.right.equalToSuperview().inset(horizontalSpacing)
        }
    }
    
    private func setUpContentContainerView() {
        addSubview(contentContainerView)
        
        contentContainerView.snp.makeConstraints { (make) in
            make.left.right.equalTo(dateLabel)
            make.top.equalTo(dateLabel.snp.bottom).offset(verticalSpacing * 0.4)
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
    
    private func setUpAddressDateLabel() {
        contentContainerView.addSubview(addressLabel)
         
        addressLabel.snp.makeConstraints { (make) in
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
