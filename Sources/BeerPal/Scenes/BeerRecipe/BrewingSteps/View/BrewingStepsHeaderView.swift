//
//  BrewingStepsHeaderView.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 15.10.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class BrewingStepsHeaderView: UITableViewHeaderFooterView {
    static let reuseID = "BrewingStepsHeaderView"
    private let verticalSpacing: CGFloat = 20
    
    let tipsLabel = ExtendableLabel()
    let contributorLabel = ExtendableLabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
}

extension BrewingStepsHeaderView {
    private func setUp() {
        setUpTipsLabel()
        setUpContributorLabel()
    }
    
    private func setUpTipsLabel() {
        tipsLabel.textColor = Theme.Colors.Texts.primary
        tipsLabel.font = .italicSystemFont(ofSize: 15)
        addSubview(tipsLabel)
        
        tipsLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(verticalSpacing)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }
    }
    
    private func setUpContributorLabel() {
        contributorLabel.textColor = Theme.Colors.Components.primary
        contributorLabel.font = .italicSystemFont(ofSize: 15)
        contributorLabel.textAlignment = .right
        addSubview(contributorLabel)
        
        contributorLabel.snp.makeConstraints { (make) in
            make.centerX.width.equalTo(tipsLabel)
            make.top.equalTo(tipsLabel.snp.bottom)
            make.bottom.equalToSuperview().inset(verticalSpacing)
        }
    }
}
