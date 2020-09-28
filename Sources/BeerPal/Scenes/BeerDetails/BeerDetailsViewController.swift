//
//  BeerDetailsViewController.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 25.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class BeerDetailsViewController: UIViewController {
    private var beerDetailsView: BeerDetailsView!
    private let viewModel: BeerDetailsItemViewModel
    
    override func loadView() {
        beerDetailsView = BeerDetailsView(using: viewModel)
        view = beerDetailsView
    }
    
    init(viewModel: BeerDetailsItemViewModel) {
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
