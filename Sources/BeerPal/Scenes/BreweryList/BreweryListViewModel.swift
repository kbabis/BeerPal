//
//  BreweryListViewModel.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 13.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import RxSwift
import RxRelay
import struct RxCocoa.Driver

final class BreweryListViewModel: ViewModelType {
    private let disposeBag = DisposeBag()
    private let repository: BreweryListRepository
    private let stateManager: DataStateManager
    weak var delegate: BreweryListDelegate?
    
    let input: BreweryListViewModel.Input
    let output: BreweryListViewModel.Output
    
    struct Input {
        let fetch = PublishRelay<Void>()
        let search = PublishRelay<String>()
        let selectedModel = PublishRelay<Brewery>()
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
        
        let outputItems = BehaviorRelay<[Brewery]>(value: [])
        let fetchedItemsRelay = BehaviorRelay<[Brewery]>(value: [])
        fetchedItemsRelay.bind(to: outputItems).disposed(by: disposeBag)
        
        let response = input.fetch
            .startWith(())
            .flatMapLatest { executeFetchRequest.materialize() }
            .share()
        
        response
            .elements
            .bind(to: fetchedItemsRelay)
            .disposed(by: disposeBag)
        
        let endRefreshing = response
            .flatMapLatest { _ in Observable.just(()) }
            .asDriver(onErrorJustReturn: ())
    
        let search = input.search
                .skip(1)
                .distinctUntilChanged()
                .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
        
        search
            .withLatestFrom(fetchedItemsRelay) { ($0, $1)  }
            .map { (phrase, breweries) -> [Brewery] in
                phrase.isEmpty
                    ? breweries
                    : breweries.filter { $0.name.contains(phrase) }
            }.bind(to: outputItems)
            .disposed(by: disposeBag)
        
        self.stateManager = stateManager
        self.repository = repository
        self.output = Output(
            state: stateManager.currentState,
            endRefreshing: endRefreshing,
            items: outputItems.asDriver()
        )
        
        setUp()
    }
    
    private func setUp() {
        input.selectedModel.subscribe(onNext: { [weak self] (item) in
            self?.delegate?.didSelect(item)
        }).disposed(by: disposeBag)
    }
}

extension BreweryListViewModel: StateManaging, DataReloading {
    var currentState: Driver<DataState> {
        return output.state
    }
    
    func reloadData() {
        input.fetch.accept(())
    }
}

extension BreweryListViewModel {
    typealias Dependencies = HasNetworking
}
