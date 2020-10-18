//
//  FoodsViewController.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 15.10.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class FoodsViewController: BaseTableViewController {
    private var foodsView: ListView!
    private let viewModel: FoodsViewModel
    
    override func loadView() {
        foodsView = ListView()
        view = foodsView
    }
    
    init(viewModel: FoodsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.title = viewModel.output.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodsView.refreshControl.removeFromSuperview()
        configureTableView(foodsView.tableView, cellType: UITableViewCell.self, estimatedRowHeight: 60)
        makeBindings()
    }
    
    private func makeBindings() {
        viewModel.output.items
            .drive(foodsView.tableView.rx.items(cellIdentifier: UITableViewCell.reuseIdentifier, cellType: UITableViewCell.self)) { (_, pairingFood, cell) in
                cell.textLabel?.text = pairingFood
            }.disposed(by: disposeBag)
    }
}
