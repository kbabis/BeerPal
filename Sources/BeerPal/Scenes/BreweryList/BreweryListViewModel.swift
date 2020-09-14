//
//  BreweryListViewModel.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 13.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import RxSwift
import RxCocoa

final class BreweryListViewModel: ViewModelType, StateManaging {
    private let disposeBag = DisposeBag()
    private let repository: BreweryListRepository
    
    let stateManager: DataStateManager = DataStateManager()
    
    private(set) var input: BreweryListViewModel.Input
    private(set) var output: BreweryListViewModel.Output
    
    struct Input {
        let fetch = PublishSubject<Void>().asObserver()
        let selectedModel = PublishSubject<Brewery>().asObserver()
    }
    
    struct Output {
        let title = R.string.localizable.breweryListTitle()
        var items: Driver<[Brewery]>?
    }
    
    init(dependencies: Dependencies) {
        repository = BreweryListRepository(networkingService: dependencies.networkingService)
        input = Input()
        output = Output()
        
        let executeFetchRequest: Observable<[Brewery]> = Observable.create { [weak self] (observer) -> Disposable in
            self?.repository.fetchBreweryList { (result) in
                switch result {
                case .success(let response):
                    observer.onNext(response.breweries)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
        
        let response = input.fetch
            .startWith(())
            .flatMapLatest { executeFetchRequest }
            .do(onNext: { (breweries) in
                print(breweries.count)
            }, onError: { (error) in
                print(error)
            })
            .share()
        
        output.items = response.asDriver(onErrorJustReturn: [])
    }
}

extension BreweryListViewModel {
    typealias Dependencies = HasNetworking
}