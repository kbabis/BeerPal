//
//  EventListViewController.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 19.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import RxSwift

final class EventListViewController: BaseTableViewController {
    private var eventListView: ListView!
    private let viewModel: EventListViewModel
    override var hasContent: Bool {
        return eventListView.tableView.numberOfRows(inSection: 0) > 0
    }
    
    override func loadView() {
        eventListView = ListView()
        view = eventListView
    }
    
    init(viewModel: EventListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.output.title
        configureTableView(eventListView.tableView, cellType: EventListItemTableViewCell.self, estimatedRowHeight: 110)
        makeBindings()
    }
    
    private func makeBindings() {
        let tableView = eventListView.tableView
        bindState(of: viewModel, dataReloader: viewModel)
        
        viewModel.output.items
            .drive(tableView.rx.items(cellIdentifier: EventListItemTableViewCell.reuseIdentifier, cellType: EventListItemTableViewCell.self)) { (_, event, cell) in
                cell.item = event
            }.disposed(by: disposeBag)

        viewModel.output.endRefreshing
            .map { false }
            .delay(.milliseconds(300))
            .drive(eventListView.refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        tableView
            .rx.modelSelected(EventListItemViewModel.self)
            .bind(to: viewModel.input.selectedModel)
            .disposed(by: disposeBag)

        tableView
            .rx.willDisplayCell
            .subscribe(onNext: { [weak self] (cell, indexPath) in
                self?.animateCell(cell, at: indexPath, of: tableView)
            }).disposed(by: disposeBag)

        eventListView.refreshControl
            .rx.controlEvent(.valueChanged)
            .bind(to: viewModel.input.fetch)
            .disposed(by: disposeBag)
    }
}
