//
//  BaseCollectionView.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 29.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class BaseCollectionView: UIView {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let refreshControl = UIRefreshControl()
    var layoutConfig: LayoutConfig
    
    init(layoutConfig: LayoutConfig, frame: CGRect = .zero) {
        self.layoutConfig = layoutConfig
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.layoutConfig = LayoutConfig(height: 250)
        super.init(coder: aDecoder)
        setUp()
    }
    
    private func setUp() {
        backgroundColor = Theme.Colors.Background.primary
        setUpCollectionView()
        setUpRefreshControl()
    }
    
    private func setUpCollectionView() {
        collectionView.delegate = self
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func setUpRefreshControl() {
        collectionView.refreshControl = refreshControl
    }
}

extension BaseCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItems = CGFloat(layoutConfig.numberOfItems)
        let availableWidth = collectionView.bounds.width - (numberOfItems - 1) * layoutConfig.interItemSpacing - layoutConfig.insets.left - layoutConfig.insets.right
        let itemWidth = abs(availableWidth) / numberOfItems
        
        return .init(width: itemWidth, height: layoutConfig.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return layoutConfig.insets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return layoutConfig.interItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return layoutConfig.interItemSpacing
    }
}

extension BaseCollectionView {
    struct LayoutConfig {
        let interItemSpacing: CGFloat = 25
        let insets: UIEdgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        let numberOfItems: Int = 2
        let height: CGFloat
    }
}
