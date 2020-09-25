//
//  BeersCoordinator.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 23.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class BeersCoordinator: NavigationCoordinator {
    private let dependencies: BeersDependencies
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController, dependencies: BeersDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        showBeerList()
    }
}

extension BeersCoordinator {
    private func showBeerList() {
        let viewModel = BeerListViewModel(dependencies: dependencies)
        viewModel.delegate = self
        let viewController = BeerListViewController(viewModel: viewModel)
        navigationController.show(viewController, sender: self)
    }
    
    private func showDetails(of beer: Beer) {
        let viewModel = BeerDetailsItemViewModel(from: beer)
        let viewController = BeerDetailsViewController(viewModel: viewModel)
        navigationController.show(viewController, sender: self)
    }
}

extension BeersCoordinator: BeerListDelegate {
    func didSelect(_ beer: Beer) {
        showDetails(of: beer)
    }
}

