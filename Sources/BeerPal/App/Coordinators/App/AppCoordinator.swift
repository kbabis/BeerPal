//
//  AppCoordinator.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 30.08.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

private enum AppCoordinatorChild {
    case onboarding
    case tabs
}

final class AppCoordinator: NavigationCoordinator {
    private var dependencies: AppDependencies
    private var childCoordinators: [AppCoordinatorChild: Coordinator]
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController, dependencies: AppDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
        self.childCoordinators = [:]
    }
    
    func start() {
        showTabs()
    }
    
    private func showOnboarding() {
        
    }
    
    private func showTabs() {
        let tabsDependencies = TabsDependencies(from: dependencies)
        let tabsCoordinator = TabsCoordinator(
            navigationController: navigationController,
            dependencies: tabsDependencies)
        tabsCoordinator.start()
        store(tabsCoordinator, as: .tabs)
    }
    
    private func store(_ coordinator: Coordinator, as type: AppCoordinatorChild) {
        childCoordinators[type] = coordinator
    }
    
    private func free(_ type: AppCoordinatorChild) {
        childCoordinators[type] = nil
    }
}
