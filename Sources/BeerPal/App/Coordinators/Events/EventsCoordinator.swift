//
//  EventsCoordinator.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 19.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class EventsCoordinator: NavigationCoordinator {
    private let dependencies: EventsDependencies
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController, dependencies: EventsDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        showEventList()
    }
}

extension EventsCoordinator {
    private func showEventList() {
        let viewModel = EventListViewModel(dependencies: dependencies)
        let viewController = EventListViewController(viewModel: viewModel)
        navigationController.show(viewController, sender: self)
    }
}

