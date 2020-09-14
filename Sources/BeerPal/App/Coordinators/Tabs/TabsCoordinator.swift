//
//  TabsCoordinator.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 29.08.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

/// the order of the cases matters - this is how the tabs will be arranged
private enum TabCoordinatorChild: Int {
    case beers
    case breweries
    case events
    case favorites
    case settings
}

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
        setUpBreweriesCoordinator()
    }
    
    private func showTabs() {
        tabsController = UITabBarController()
        tabsController?.viewControllers = childCoordinators.sorted(by: { $0.0.rawValue < $1.0.rawValue }).map { $0.value.navigationController }
        navigationController.isNavigationBarHidden = true
        navigationController.setViewControllers([tabsController!], animated: false)
    }
}

extension TabsCoordinator {
    private func createTabNavigationController(title: String, image: UIImage?) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        return navigationController
    }
    
    private func store(_ coordinator: NavigationCoordinator, as type: TabCoordinatorChild) {
        childCoordinators[type] = coordinator
    }
}

extension TabsCoordinator {
    private func setUpBeersCoordinator() {
        
    }
    
    private func setUpBreweriesCoordinator() {
        let tabNavigationController = createTabNavigationController(
            title: R.string.localizable.tabsBreweries(),
            image: UIImage()) ; #warning("TODO: Set icon")
        let coordinator = BreweryCoordinator(
            navigationController: tabNavigationController,
            dependencies: BreweryDependencies(from: dependencies)
        )
        coordinator.start()
        store(coordinator, as: .breweries)
    }
}


