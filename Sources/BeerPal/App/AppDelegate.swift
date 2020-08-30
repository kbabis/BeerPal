//
//  AppDelegate.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 25.08.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appCoordinator = AppCoordinator(
            navigationController: UINavigationController(),
            dependencies: AppDependencies()
        )
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appCoordinator?.navigationController
        appCoordinator?.start()
        window?.makeKeyAndVisible()
        
        return true
    }
}
