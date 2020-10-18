//
//  PagesView.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 13.10.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class PagesView: UIView {
    let segmentedControl = UISegmentedControl()
    let pagesContainerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
}

extension PagesView {
    private func setUp() {
        setUpSegmentedControl()
        setUpPagesContainerView()
    }
    
    private func setUpSegmentedControl() {
        addSubview(segmentedControl)
        segmentedControl.setTitleTextAttributes([.foregroundColor: Theme.Colors.Components.primary], for: .normal)
        segmentedControl.setTitleTextAttributes([.foregroundColor: Theme.Colors.Components.foreground], for: .selected)
        
        if #available(iOS 13.0, *) {
            segmentedControl.selectedSegmentTintColor = Theme.Colors.Components.primary
        } else {
            segmentedControl.tintColor = Theme.Colors.Components.primary
        }
        
        segmentedControl.snp.makeConstraints { (make) in
            make.top.centerX.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private func setUpPagesContainerView() {
        addSubview(pagesContainerView)
        
        pagesContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.left.right.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
