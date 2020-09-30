//
//  BreweryCoordinator.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 14.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class BreweryCoordinator: NavigationCoordinator {
    private let dependencies: BreweryDependencies
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController, dependencies: BreweryDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        showBreweryList()
    }
}

extension BreweryCoordinator {
    private func showBreweryList() {
        let viewModel = BreweryListViewModel(dependencies: dependencies)
        viewModel.delegate = self
        let viewController = BreweryListViewController(viewModel: viewModel)
        navigationController.show(viewController, sender: self)
    }
    
    private func showDetails(of brewery: Brewery) {
        let viewModel = BreweryDetailsItemViewModel(from: brewery)
        let viewController = BreweryDetailsViewController(viewModel: viewModel)
        navigationController.show(viewController, sender: self)
    }
}

extension BreweryCoordinator: BreweryListDelegate {
    func didSelect(_ brewery: Brewery) {
        showDetails(of: brewery)
    }
}


