//
//  BeerPropertyView.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 27.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class BeerPropertyView: UIView {
    private let imageView = UIImageView()
    private let spacerView = UIView()
    private let nameLabel = BeerPropertyNameLabel()
    private let valueLabel = BeerPropertyValueLabel()
    var isImageViewCircular = false
    
    var name: String? {
        didSet { nameLabel.text = name }
    }
    
    var value: String? {
        didSet { valueLabel.text = value }
    }
    
    var image: UIImage? {
        didSet { imageView.image = image?.withRenderingMode(.alwaysTemplate) }
    }
    
    var imageColor: UIColor? {
        didSet { imageView.tintColor = imageColor }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if isImageViewCircular {
            imageView.layer.cornerRadius = imageView.frame.width * 0.5
        }
    }
    
    func setImageViewBorder(width: CGFloat, color: UIColor = Theme.Colors.Background.inverted) {
        imageView.layer.borderWidth = width
        imageView.layer.borderColor = color.cgColor
    }
}

extension BeerPropertyView {
    private func setUp() {
        setUpImageView()
        setUpSpacerView()
        setUpValueLabel()
        setUpNameLabel()
    }
    
    private func setUpImageView() {
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Theme.Colors.Texts.primary
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.left.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.4)
            make.width.equalTo(imageView.snp.width)
        }
    }
    
    private func setUpSpacerView() {
        addSubview(spacerView)
        spacerView.snp.makeConstraints { (make) in
            make.left.equalTo(imageView.snp.right)
            make.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.2)
        }
    }
    
    private func setUpValueLabel() {
        addSubview(valueLabel)
        valueLabel.snp.makeConstraints { (make) in
            make.left.equalTo(spacerView.snp.right)
            make.right.bottom.equalToSuperview()
        }
    }
    
    private func setUpNameLabel() {
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(spacerView.snp.right)
            make.top.equalToSuperview()
            make.bottom.equalTo(nameLabel.snp.top).priority(.medium)
        }
    }
}

private class BeerPropertyNameLabel: BaseLabel {
    override func setUp() {
        super.setUp()
        textColor = Theme.Colors.Texts.secondary
        font = Theme.Fonts.getFont(ofSize: .small, weight: .regular)
        adjustsFontSizeToFitWidth = true
    }
}

private class BeerPropertyValueLabel: BaseLabel {
    override func setUp() {
        super.setUp()
        font = Theme.Fonts.getFont(ofSize: .xxxxLarge, weight: .bold)
        adjustsFontSizeToFitWidth = true
    }
}
