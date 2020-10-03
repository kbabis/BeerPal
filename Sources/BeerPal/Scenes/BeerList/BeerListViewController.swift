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
        addSearchBar(placeholder: R.string.localizable.beerListSearchBar())
        configureTableView(beerListView.tableView, cellType: BeerListItemTableViewCell.self, estimatedRowHeight: 110)
        makeBindings()
    }
    
    private func makeBindings() {
        let tableView = beerListView.tableView
        
        viewModel.output.state
            .map { $0.items }
            .drive(tableView.rx.items(cellIdentifier: BeerListItemTableViewCell.reuseIdentifier, cellType: BeerListItemTableViewCell.self)) { (_, beer, cell) in
                cell.item = beer
            }.disposed(by: disposeBag)

        viewModel.output.state
            .drive { [weak self] (state) in
                self?.handleUpdate(of: state)
            }.disposed(by: disposeBag)
        
        viewModel.output.state
            .map { $0.shouldLoadNext }
            .filter { !$0 }
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
        
        tableView
            .rx.reachedBottom(offset: 200)
            .map { BeerListEvent.loadNextPage }
            .bind(to: viewModel.input.events)
            .disposed(by: disposeBag)
        
        navigationItem.searchController?.searchBar
            .rx.text
            .orEmpty
            .map { BeerListEvent.search(phrase: $0) }
            .bind(to: viewModel.input.events )
            .disposed(by: disposeBag)
        
        beerListView.refreshControl
            .rx.controlEvent(.valueChanged)
            .map { BeerListEvent.reload }
            .bind(to: viewModel.input.events)
            .disposed(by: disposeBag)
        
        setDataReloader(viewModel)
    }
    
    private func handleUpdate(of state: BeerListState) {
        loadingStateView.alpha = (state.shouldLoadNext && state.items.isEmpty) ? 1 : 0
        
        if let error = state.error {
            showError(error.localizedDescription, isDataOriented: !state.items.isEmpty)
        } else {
            errorStateView.alpha = 0
        }
    }
}
