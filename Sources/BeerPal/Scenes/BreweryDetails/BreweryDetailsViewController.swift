//
//  BreweryDetailsViewController.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 30.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class BreweryDetailsViewController: UIViewController {
    private var breweryDetailsView: BreweryDetailsView!
    private let viewModel: BreweryDetailsItemViewModel
    
    override func loadView() {
        breweryDetailsView = BreweryDetailsView(using: viewModel)
        view = breweryDetailsView
    }
    
    init(viewModel: BreweryDetailsItemViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
}
