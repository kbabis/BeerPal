//
//  EmptyStateView.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 01.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class EmptyStateView: BaseStateView {    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    func setUp() {
        title = R.string.localizable.stateEmptyDefaultTitle()
        message = R.string.localizable.stateEmptyDefaultMessage()
    }
}
