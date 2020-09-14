//
//  TagView.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 13.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class TagView: UIView {
    private let horizontalInset: CGFloat = 8.0
    private let verticalInset: CGFloat = 4.0
    
    let titleLabel = TagTitleLabel()
    
    convenience init(title: String, color: UIColor) {
        self.init()
        self.titleLabel.text = title
        self.backgroundColor = color
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    private func setUp() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(horizontalInset)
            make.top.equalToSuperview().offset(verticalInset)
            make.right.equalToSuperview().inset(horizontalInset)
            make.bottom.equalToSuperview().inset(verticalInset)
        }
    }
}

final class TagTitleLabel: BaseLabel {
    override func setUp() {
        super.setUp()
        textColor = .white
        font = Theme.Fonts.getFont(ofSize: .small, weight: .medium)
    }
}
