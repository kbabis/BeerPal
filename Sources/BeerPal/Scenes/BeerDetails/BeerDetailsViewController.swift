//
//  BeerDetailsViewController.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 25.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit
import class RxSwift.DisposeBag

final class BeerDetailsViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private var beerDetailsView: BeerDetailsView!
    private let viewModel: BeerDetailsViewModel
    
    override func loadView() {
        beerDetailsView = BeerDetailsView(using: viewModel.output.item)
        view = beerDetailsView
    }
    
    init(viewModel: BeerDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        makeBindings()
    }
    
    private func makeBindings() {
        beerDetailsView.recipeButton
            .rx.tap
            .bind(to: viewModel.input.openRecipe)
            .disposed(by: disposeBag)
    }
}
