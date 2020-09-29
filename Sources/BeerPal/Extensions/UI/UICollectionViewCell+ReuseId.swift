//
//  UICollectionViewCell+ReuseId.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 29.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
}
