//
//  LoadingStateView.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 01.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class LoadingStateView: UIView {
    private let activityIndicatorView = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    private func setUp() {
        setUpActivityIndicatorView()
    }
    
    private func setUpActivityIndicatorView() {
        activityIndicatorView.color = .systemGray
        activityIndicatorView.startAnimating()
        addSubview(activityIndicatorView)
        
        activityIndicatorView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
