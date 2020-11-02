//
//  DetailsFieldView.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 20.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

class DetailsFieldView: UIView {
    private let horizontalSpacing: CGFloat = 5
    
    private let iconLabel = BaseLabel()
    private let titleLabel = PropertyLabel()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setUp()
    }
    
    convenience init(text: String, icon: String?) {
        self.init()
        set(text: text, icon: icon)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    func set(text: String?, icon: String?) {
        titleLabel.text = text
        iconLabel.text = icon
    }
}

extension DetailsFieldView {
    private func setUp() {
        setUpIconLabel()
        setUpTitleLabel()
    }
    
    private func setUpIconLabel() {
        addSubview(iconLabel)

        iconLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalTo(25)
        }
    }

    private func setUpTitleLabel() {
        addSubview(titleLabel)

        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconLabel.snp.right).offset(horizontalSpacing)
            make.top.equalTo(iconLabel)
            make.right.equalToSuperview()
            //make.bottom.greaterThanOrEqualTo(iconImageView).priority(.medium)
            make.bottom.equalToSuperview().priority(.medium)
        }
    }
}
