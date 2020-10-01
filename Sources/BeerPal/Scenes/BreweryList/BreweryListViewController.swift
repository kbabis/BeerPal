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
    private var breweryCollectionView: BaseCollectionView!
    private let viewModel: BreweryListViewModel
    override var hasContent: Bool {
        return breweryCollectionView.collectionView.numberOfItems(inSection: 0) > 0
    }
    
    override func loadView() {
        breweryCollectionView = BaseCollectionView(layoutConfig: .init(widthHeightRatio: 29/36))
        view = breweryCollectionView
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
        setUpSearchController()
        breweryCollectionView.collectionView.register(
            BreweryItemCollectionViewCell.self,
            forCellWithReuseIdentifier: BreweryItemCollectionViewCell.reuseIdentifier)
        makeBindings()
    }
    
    private func makeBindings() {
        let collectionView = breweryCollectionView.collectionView
        bindState(of: viewModel, dataReloader: viewModel)
        
        viewModel.output.items
            .drive(collectionView.rx.items(cellIdentifier: BreweryItemCollectionViewCell.reuseIdentifier, cellType: BreweryItemCollectionViewCell.self)) { (_, brewery, cell) in
                cell.item = brewery
            }.disposed(by: disposeBag)
        
        viewModel.output.endRefreshing
            .map { false }
            .delay(.milliseconds(300))
            .drive(breweryCollectionView.refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        collectionView
            .rx.modelSelected(Brewery.self)
            .bind(to: viewModel.input.selectedModel)
            .disposed(by: disposeBag)
        
        navigationItem.searchController?.searchBar
            .rx.text
            .orEmpty
            .bind(to: viewModel.input.search)
            .disposed(by: disposeBag)
        
        breweryCollectionView.refreshControl
            .rx.controlEvent(.valueChanged)
            .bind(to: viewModel.input.fetch)
            .disposed(by: disposeBag)
    }
    
    private func setUpSearchController() {
        let searchController = UISearchController()
        searchController.searchBar.tintColor = Theme.Colors.Components.primary
        searchController.dimsBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
}
