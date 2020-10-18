//
//  BrewingStepsViewModel.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 15.10.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import struct RxCocoa.Driver
import class RxSwift.Observable

final class BrewingStepsViewModel: ViewModelType {
    let input: BrewingStepsViewModel.Input
    let output: BrewingStepsViewModel.Output
    
    struct Input {}
    
    struct Output {
        let title = "Method"
        let tips: Driver<String>
        let contributor: Driver<String>
        let items: Driver<[BrewageMethodStep]>
    }
    
    init(with beer: Beer) {
        let methodSteps = Observable.just(beer.method)
            .map { Self.makeMethodSteps(from: $0) }
        
        self.input = Input()
        self.output = Output(
            tips: Observable.just(beer.brewersTips).asDriver(onErrorJustReturn: ""),
            contributor: Observable.just(beer.contributedBy).asDriver(onErrorJustReturn: ""),
            items: methodSteps.asDriver(onErrorJustReturn: [])
        )
    }
    
    private static func makeMethodSteps(from method: Beer.Method) -> [BrewageMethodStep] {
        var steps: [BrewageMethodStep] = []
        
        for mash in method.mashTemp {
            var mashStep = mash.temp.description
            
            if let duration = mash.duration {
                mashStep.append(String(format: " for %d min", duration))
            }
            
            steps.append(mashStep)
        }
            
        let fermentationStep = R.string.localizable.beerDetailsMethodFerment() + " " + method.fermentation.temp.description
        steps.append(fermentationStep)
        
        if let twist = method.twist {
            let twistStep = R.string.localizable.beerDetailsMethodTwist() + ": " + twist
            steps.append(twistStep)
        }
        
        return steps
    }
}

extension BrewingStepsViewModel {
    typealias BrewageMethodStep = String
}

private extension Beer.Measure {
    var description: String {
        if let value = value {
            return String(format: "%.1d %@", value, unit)
        } else {
            return ""
        }
    }
}
