//
//  Observable+Materialize.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 16.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation
import RxSwift

extension ObservableType where Element: EventConvertible {
    var elements: Observable<Element.Element> {
        return compactMap { $0.event.element }
    }

    var errors: Observable<Swift.Error> {
        return compactMap { $0.event.error }
    }
}
