//
//  BreweryListViewController.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 13.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import RxSwift
import RxCocoa

final class BreweryListViewController: BaseViewController {
    private var breweryListView: BreweryListView!
    private let viewModel: BreweryListViewModel
    override var hasContent: Bool {
        return breweryListView.tableView.numberOfRows(inSection: 0) > 0
    }
    
    override func loadView() {
        breweryListView = BreweryListView()
        view = breweryListView
    }
    
    init(viewModel: BreweryListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.output.title
        configureTableView()
        makeBindings()
    }
    
    private func makeBindings() {
        bindState(of: viewModel, dataReloader: viewModel)
        
        viewModel.output.items
            .drive(breweryListView.tableView.rx.items(cellIdentifier: BreweryListItemTableViewCell.reuseIdentifier, cellType: BreweryListItemTableViewCell.self)) { (_, brewery, cell) in
                cell.item = brewery
            }.disposed(by: disposeBag)
        
        viewModel.output.endRefreshing
            .map { false }
            .delay(.milliseconds(300))
            .drive(breweryListView.refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        breweryListView.tableView
            .rx.modelSelected(Brewery.self)
            .bind(to: viewModel.input.selectedModel)
            .disposed(by: disposeBag)
        
        breweryListView.refreshControl
            .rx.controlEvent(.valueChanged)
            .bind(to: viewModel.input.fetch)
            .disposed(by: disposeBag)
    }
    
    private func configureTableView() {
        breweryListView.tableView.register(BreweryListItemTableViewCell.self, forCellReuseIdentifier: BreweryListItemTableViewCell.reuseIdentifier)
        breweryListView.tableView.estimatedRowHeight = 90
        breweryListView.tableView.rowHeight = UITableView.automaticDimension
        breweryListView.tableView.separatorStyle = .none
    }
}
