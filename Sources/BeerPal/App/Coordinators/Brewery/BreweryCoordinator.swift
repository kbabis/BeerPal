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
        let viewController = BreweryListViewController(viewModel: viewModel)
        navigationController.show(viewController, sender: self)
    }
}


