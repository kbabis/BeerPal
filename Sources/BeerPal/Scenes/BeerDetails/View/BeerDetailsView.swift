//
//  BeerDetailsView.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 24.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class BeerDetailsView: UIView {
    init(using beer: BeerDetailsItemViewModel, frame: CGRect = .zero) {
        super.init(frame: frame)
        setUp()
        fill(with: beer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    private func setUp() {}
    private func fill(with beer: BeerDetailsItemViewModel) {
    }
}
