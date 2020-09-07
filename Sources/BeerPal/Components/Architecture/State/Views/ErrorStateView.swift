//
//  ErrorStateView.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 01.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class ErrorStateView: BaseStateView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    private func setUp() {
        title = R.string.localizable.stateErrorDefaultTitle()
        message = R.string.localizable.stateErrorDefaultMessage()
    }
}
