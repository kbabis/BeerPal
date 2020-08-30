//
//  CoordinatorMock.swift
//  BeerPalTests
//
//  Created by Krzysztof Babis on 29.08.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit
@testable import BeerPal

final class CoordinatorMock: NavigationCoordinator {
    let navigationController: UINavigationController
    var startingViewController: UIViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        guard let startingViewController = startingViewController else { return }
        
        navigationController.viewControllers = [startingViewController]
    }
}
