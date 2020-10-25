//
//  FoodsViewModel.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 15.10.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import struct RxCocoa.Driver
import class RxSwift.Observable

final class FoodsViewModel: ViewModelType {
    let input: FoodsViewModel.Input
    let output: FoodsViewModel.Output
    
    struct Input {}
    
    struct Output {
        let title = "Pairing foods"
        var items: Driver<[String]>
    }
    
    init(with beer: Beer) {
        let foods = Observable.just(beer.foodPairing)
        
        self.input = Input()
        self.output = Output(items: foods.asDriver(onErrorJustReturn: []))
    }
}
