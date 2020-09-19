//
//  BaseTableViewController.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 19.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

class BaseTableViewController: BaseViewController {
    private var animator: TableViewAnimator?
    
    func configureTableView<CellType: UITableViewCell>(_ tableView: UITableView, cellType: CellType.Type, estimatedRowHeight: CGFloat, rowHeight: CGFloat = UITableView.automaticDimension) {
        tableView.register(CellType.self, forCellReuseIdentifier: CellType.reuseIdentifier)
        tableView.estimatedRowHeight = estimatedRowHeight
        tableView.rowHeight = rowHeight
        tableView.separatorStyle = .none
    }
    
    func animateCell(_ cell: UITableViewCell, at indexPath: IndexPath, of tableView: UITableView) {
        let animation = TableViewAnimationFactory.makeTopSlide(offset: cell.frame.height, duration: 0.8)
        if animator == nil {
            animator = TableViewAnimator(animation: animation)
        }
        
        animator?.animate(cell: cell, at: indexPath, in: tableView)
    }
}
