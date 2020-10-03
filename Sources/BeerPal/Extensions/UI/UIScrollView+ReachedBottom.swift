//
//  UIScrollView+ReachedBottom.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 03.10.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import struct RxSwift.Reactive
import RxCocoa

public extension Reactive where Base: UIScrollView {
    func reachedBottom(offset: CGFloat = 0.0) -> ControlEvent<Void> {
        let source = contentOffset.map { contentOffset in
            let visibleHeight = self.base.frame.height - self.base.contentInset.top - self.base.contentInset.bottom
            let y = contentOffset.y + self.base.contentInset.top
            let threshold = max(offset, self.base.contentSize.height - visibleHeight)
            
            return y >= threshold
        }.distinctUntilChanged()
        .filter { $0 }
        .map { _ in () }
        return ControlEvent(events: source)
    }
}
