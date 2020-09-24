//
//  BeerListViewModel.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 24.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import RxSwift
import struct RxCocoa.Driver
import class RxRelay.PublishRelay

final class BeerListViewModel: ViewModelType {
    private let disposeBag = DisposeBag()
    private let repository: BeerListRepository
    private let stateManager: DataStateManager
    
    let input: BeerListViewModel.Input
    let output: BeerListViewModel.Output
    
    struct Input {
        let loadNextPage = PublishSubject<Void>()
        let searchText = PublishSubject<String>()
        let selectedModel = PublishRelay<BeerListItemViewModel>()
    }
    
    struct Output {
        let title = R.string.localizable.beerListTitle()
        var state: Driver<DataState>
        var endRefreshing: Driver<Void>
        var items: Driver<[BeerListItemViewModel]>
    }
    
    init(dependencies: Dependencies) {
        let stateManager = DataStateManager()
        let repository = BeerListRepository(networkingService: dependencies.networkingService)
        let input = Input()

        let response = input.searchText
            .filter { !$0.isEmpty }
            .distinctUntilChanged()
            .flatMapLatest { searchText in
                return input.loadNextPage.asObservable()
                    .startWith(())
                    .scan(0) { (pageNumber, _) -> UInt in
                        pageNumber + 1
                    }
                    .map { pageNumber in
                        (searchText, pageNumber)
                    }
            }
        .flatMapLatest { (searchText, page) -> Observable<[BeerListItemViewModel]> in
            return Observable.create { (observer) -> Disposable in
                stateManager.update(.loading)
                
                repository.fetchBeers(name: searchText, page: Int(page), then: { (result) in
                    switch result {
                    case .success(let beers):
                        stateManager.update(beers.isEmpty ? .empty("") : .loaded)
                        let items = beers.map { BeerListItemViewModel(with: $0) }
                        observer.onNext(items)
                        observer.onCompleted()
                    case .failure(let error):
                        stateManager.update(.error(error.localizedDescription))
                        observer.onError(error)
                    }
                })
                
                return Disposables.create()
            }
        }.materialize()
        .share()
        
        let endRefreshing = response
            .flatMapLatest { _ in Observable.just(()) }
            .asDriver(onErrorJustReturn: ())
        
        self.stateManager = stateManager
        self.repository = repository
        self.input = input
        self.output = Output(
            state: stateManager.currentState,
            endRefreshing: endRefreshing,
            items: response.elements.asDriver(onErrorJustReturn: [])
        )
    }
}

extension BeerListViewModel: StateManaging, DataReloading {
    var currentState: Driver<DataState> {
        return output.state
    }
    
    func reloadData() {
        input.searchText.onNext("punk")
    }
}

extension BeerListViewModel {
    typealias Dependencies = HasNetworking
}
