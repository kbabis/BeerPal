//
//  TableViewAnimator.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 17.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class TableViewAnimator {
    private var didAnimate = false
    private let animation: Animation

    init(animation: @escaping Animation) {
        self.animation = animation
    }

    func animate(cell: UITableViewCell, at indexPath: IndexPath, in tableView: UITableView) {
        guard !didAnimate else { return }

        animation(cell, indexPath, tableView)
        didAnimate = (indexPath == tableView.indexPathsForVisibleRows?.last)
    }
}

extension TableViewAnimator {
    typealias Animation = (UITableViewCell, IndexPath, UITableView) -> Void
}
