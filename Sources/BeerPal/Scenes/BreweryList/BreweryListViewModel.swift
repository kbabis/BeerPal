//
//  BreweryListViewModel.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 13.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import RxSwift
import RxCocoa

final class BreweryListViewModel: ViewModelType {
    private let disposeBag = DisposeBag()
    private let repository: BreweryListRepository
    private let stateManager: DataStateManager
    
    let input: BreweryListViewModel.Input
    let output: BreweryListViewModel.Output
    
    struct Input {
        let fetch = PublishSubject<Void>().asObserver()
        let selectedModel = PublishSubject<Brewery>().asObserver()
    }
    
    struct Output {
        let title = R.string.localizable.breweryListTitle()
        var state: Driver<DataState>
        var endRefreshing: Driver<Void>
        var items: Driver<[Brewery]>
    }
    
    init(dependencies: Dependencies) {
        let stateManager = DataStateManager()
        let repository = BreweryListRepository(networkingService: dependencies.networkingService)
        self.input = Input()
        
        let executeFetchRequest: Observable<[Brewery]> = Observable.create { (observer) -> Disposable in
            stateManager.update(.loading)
            
            repository.fetchBreweryList { (result) in
                switch result {
                case .success(let response):
                    stateManager.update(response.breweries.isEmpty ? .empty("") : .loaded)
                    observer.onNext(response.breweries)
                    observer.onCompleted()
                case .failure(let error):
                    stateManager.update(.error(error.localizedDescription))
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
        
        let response = input.fetch
            .startWith(())
            .flatMapLatest { executeFetchRequest.materialize() }
            .share()
        
        let endRefreshing = response
            .flatMapLatest { _ in Observable.just(()) }
            .asDriver(onErrorJustReturn: ())
        
        self.stateManager = stateManager
        self.repository = repository
        self.output = Output(
            state: stateManager.currentState,
            endRefreshing: endRefreshing,
            items: response.elements.asDriver(onErrorJustReturn: [])
        )
    }
}

extension BreweryListViewModel: StateManaging, DataReloading {
    var currentState: Driver<DataState> {
        return output.state
    }
    
    func reloadData() {
        input.fetch.onNext(())
    }
}

extension BreweryListViewModel {
    typealias Dependencies = HasNetworking
}
