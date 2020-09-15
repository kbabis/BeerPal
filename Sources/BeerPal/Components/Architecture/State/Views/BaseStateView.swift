//
//  BaseStateView.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 01.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit
import SnapKit

class BaseStateView: UIView {
    private let spacing: CGFloat = 10.0
    
    private let iconImageView = UIImageView()
    private let titleLabel = BaseStateTitleLabel()
    private let messageLabel = BaseStateMessageLabel()
    private let reloadButton = BaseStateReloadButton()
    
    var icon: UIImage? {
        didSet { iconImageView.image = icon }
    }
    
    var title: String = "" {
        didSet { titleLabel.text = title }
    }
    
    var message: String = "" {
        didSet { messageLabel.text = message }
    }
    
    weak var reloadingDelegate: DataReloading?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    private func setUp() {
        setUpIconImageView()
        setUpTitleLabel()
        setUpMessageLabel()
        setUpReloadButton()
    }
    
    private func setUpIconImageView() {
        addSubview(iconImageView)
        
        iconImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-130)
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(iconImageView.snp.width)
        }
    }
    
    private func setUpTitleLabel() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImageView.snp.bottom).offset(spacing)
            make.centerX.equalToSuperview()
            make.width.equalTo(iconImageView)
        }
    }
    
    private func setUpMessageLabel() {
        addSubview(messageLabel)
        
        messageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(spacing * 0.25)
            make.centerX.width.equalTo(titleLabel)
        }
    }
    
    private func setUpReloadButton() {
        addSubview(reloadButton)
        reloadButton.addTarget(self, action: #selector(reload), for: .touchUpInside)
        
        reloadButton.snp.makeConstraints { (make) in
            make.top.equalTo(messageLabel.snp.bottom).offset(spacing * 2)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(50.0)
        }
    }
    
    @objc private func reload() {
        reloadingDelegate?.reloadData()
    }
}

private class BaseStateTitleLabel: BaseLabel {
    override func setUp() {
        super.setUp()
        font = Theme.Fonts.getFont(ofSize: .large, weight: .medium)
        textAlignment = .center
        numberOfLines = 0
    }
}

private class BaseStateMessageLabel: BaseLabel {
    override func setUp() {
        super.setUp()
        font = Theme.Fonts.getFont(ofSize: .medium, weight: .medium)
        textAlignment = .center
        numberOfLines = 0
    }
}

private class BaseStateReloadButton: BaseButton {
    override func setUp() {
        super.setUp()
        setTitle(R.string.localizable.stateBaseReloadButton(), for: .normal)
    }
}

