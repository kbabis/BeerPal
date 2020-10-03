//
//  UIViewController+SearchBar.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 03.10.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

extension UIViewController {
    func addSearchBar(placeholder: String? = nil) {
        let searchController = UISearchController()
        searchController.searchBar.tintColor = Theme.Colors.Components.primary
        searchController.dimsBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        
        if let placeholder = placeholder {
            searchController.searchBar.placeholder = placeholder
        }
    }
}
