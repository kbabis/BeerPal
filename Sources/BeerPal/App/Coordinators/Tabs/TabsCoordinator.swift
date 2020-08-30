//
//  TabsCoordinator.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 29.08.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class TabsCoordinator: NavigationCoordinator {
    private var tabsController: UITabBarController?
    private var childCoordinators: [TabCoordinatorChild: NavigationCoordinator]
    private let dependencies: TabsDependencies
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController, dependencies: TabsDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
        self.childCoordinators = [:]
    }
    
    func start() {
        setUpTabCoordinators()
        showTabs()
    }
    
    private func setUpTabCoordinators() {
        setUpBeersCoordinator()
    }
    
    private func showTabs() {
        tabsController = UITabBarController()
        tabsController?.viewControllers = childCoordinators.sorted(by: { $0.0.rawValue < $1.0.rawValue }).map { $0.value.navigationController }
        navigationController.setViewControllers([tabsController!], animated: false)
    }
}

extension TabsCoordinator {
    private func setUpBeersCoordinator() {
        
    }
}

extension TabsCoordinator {
    /// the order of the cases matters - this is how the tabs will be arranged
    enum TabCoordinatorChild: Int {
        case beers
        case breweries
        case events
        case favorites
        case settings
    }
}


