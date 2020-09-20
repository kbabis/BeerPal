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

extension EventsCoordinator: EventListDelegate {
    func didSelect(_ event: Event) {
        showDetails(of: event)
    }
}

extension EventsCoordinator {
    private func showEventList() {
        let viewModel = EventListViewModel(dependencies: dependencies)
        viewModel.delegate = self
        let viewController = EventListViewController(viewModel: viewModel)
        navigationController.show(viewController, sender: self)
    }
    
    private func showDetails(of event: Event) {
        let viewModel = EventDetailsViewModel(from: event)
        let viewController = EventDetailsViewController(viewModel: viewModel)
        navigationController.show(viewController, sender: self)
    }
}

