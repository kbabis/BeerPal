//
//  BeerDetailsViewModel.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 25.10.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import class RxSwift.DisposeBag
import class RxCocoa.PublishRelay

final class BeerDetailsViewModel: ViewModelType {
    private let disposeBag = DisposeBag()
    weak var delegate: BeerDetailsDelegate?
    
    let input: Input
    let output: Output
    
    struct Input {
        let openRecipe: PublishRelay<Void>
    }
    
    struct Output {
        let item: BeerDetailsItemViewModel
    }
    
    init(from beer: Beer) {
        self.input = Input(openRecipe: PublishRelay<Void>())
        self.output = Output(item: BeerDetailsItemViewModel(from: beer))
        
        input.openRecipe
            .subscribe(onNext: { [weak self] (_) in
                self?.delegate?.showRecipe(of: beer)
            }).disposed(by: disposeBag)
    }
}
