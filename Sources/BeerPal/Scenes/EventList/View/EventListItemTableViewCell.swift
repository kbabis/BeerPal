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
    private var typeLabel = TypeLabel()
    
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
        setUpContentContainerView()
        setUpLogoImageView()
        setUpNameLabel()
        setUpAddressLabel()
        setUpTypeLabel()
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
    
    private func setUpAddressLabel() {
        contentContainerView.addSubview(addressLabel)
         
        addressLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(verticalSpacing * 0.25)
        }
    }
    
    private func setUpTypeLabel() {
        typeLabel.textInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        contentContainerView.addSubview(typeLabel)
        
        typeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(addressLabel.snp.bottom).offset(verticalSpacing * 0.5)
            make.right.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().inset(5)
        }
    }
}

private class TypeLabel: BaseLabel {
    var textInsets: UIEdgeInsets = .zero {
        didSet { invalidateIntrinsicContentSize() }
    }

    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: textInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textInsets.top,
                                          left: -textInsets.left,
                                          bottom: -textInsets.bottom,
                                          right: -textInsets.right)
        return textRect.inset(by: invertedInsets)
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 5.0
        layer.masksToBounds = true
    }
    
    override func setUp() {
        super.setUp()
        backgroundColor = Theme.Colors.Components.primary
        textColor = Theme.Colors.Components.foreground
        font = Theme.Fonts.getFont(ofSize: .small, weight: .semibold)
    }
}
