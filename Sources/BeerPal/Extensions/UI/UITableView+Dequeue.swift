//
//  UITableView+Dequeue.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 23.10.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}
