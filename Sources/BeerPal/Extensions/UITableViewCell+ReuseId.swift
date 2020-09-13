//
//  UITableViewCell+ReuseId.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 13.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
}
