//
//  DetailsFieldView.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 20.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class DetailsFieldView: UIView {
    private let horizontalSpacing: CGFloat = 5
    private let verticalSpacing: CGFloat = 10
    
    private let iconImageView = UIImageView()
    private let titleLabel = ExtendableLabel()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setUp()
    }
    
    convenience init(text: String, icon: UIImage?) {
        self.init()
        set(text: text, icon: icon)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    func set(text: String, icon: UIImage?) {
        titleLabel.text = text
        iconImageView.image = icon
    }
}

extension DetailsFieldView {
    private func setUp() {
        setUpIconImageView()
        setUpTitleLabel()
    }
    
    private func setUpIconImageView() {
        iconImageView.contentMode = .scaleAspectFit
        addSubview(iconImageView)

        iconImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(verticalSpacing)
            make.height.width.equalTo(18)
        }
    }

    private func setUpTitleLabel() {
        addSubview(titleLabel)

        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(horizontalSpacing)
            make.top.equalTo(iconImageView)
            make.right.equalToSuperview()
            //make.bottom.greaterThanOrEqualTo(iconImageView).priority(.medium)
            make.bottom.equalToSuperview().inset(verticalSpacing)
        }
    }
}
