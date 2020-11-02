//
//  InteractiveDetailsFieldView.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 20.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit
import RxSwift
import struct RxCocoa.ControlEvent

final class InteractiveDetailsFieldView: DetailsFieldView {
    let fillButton = UIButton()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    private func setUp() {
        addSubview(fillButton)
        
        fillButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension Reactive where Base: InteractiveDetailsFieldView {
    var tap: ControlEvent<Void> {
        return base.fillButton.rx.tap
    }
}
