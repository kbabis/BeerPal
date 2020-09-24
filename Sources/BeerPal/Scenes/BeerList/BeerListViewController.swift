//
//  BeerListViewController.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 23.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import RxSwift

final class BeerListViewController: BaseTableViewController {
    private var beerListView: ListView!
    private let viewModel: BeerListViewModel
    override var hasContent: Bool {
        return beerListView.tableView.numberOfRows(inSection: 0) > 0
    }
    
    override func loadView() {
        beerListView = ListView()
        view = beerListView
    }
    
    init(viewModel: BeerListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.output.title
        configureTableView(beerListView.tableView, cellType: BeerListItemTableViewCell.self, estimatedRowHeight: 110)
        makeBindings()
    }
    
    private func makeBindings() {
        let tableView = beerListView.tableView
        bindState(of: viewModel, dataReloader: viewModel)
                
        viewModel.output.items
            .drive(tableView.rx.items(cellIdentifier: BeerListItemTableViewCell.reuseIdentifier, cellType: BeerListItemTableViewCell.self)) { (_, beer, cell) in
                cell.item = beer
            }.disposed(by: disposeBag)
        
        viewModel.output.endRefreshing
            .map { false }
            .delay(.milliseconds(300))
            .drive(beerListView.refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
                
        tableView
            .rx.modelSelected(BeerListItemViewModel.self)
            .bind(to: viewModel.input.selectedModel)
            .disposed(by: disposeBag)
        
        tableView
            .rx.willDisplayCell
            .subscribe(onNext: { [weak self] (cell, indexPath) in
                self?.animateCell(cell, at: indexPath, of: tableView)
            }).disposed(by: disposeBag)
        
        beerListView.refreshControl
            .rx.controlEvent(.valueChanged)
            .bind(to: viewModel.input.loadNextPage)
            .disposed(by: disposeBag)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            [weak self] in
            self?.viewModel.input.searchText.onNext("ipa")
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {
            [weak self] in
            self?.viewModel.input.loadNextPage.onNext(())
        })
        
        
    }
}
