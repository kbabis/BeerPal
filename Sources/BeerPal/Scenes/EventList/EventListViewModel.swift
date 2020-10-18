//
//  EventListViewModel.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 19.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import RxSwift
import struct RxCocoa.Driver
import class RxRelay.PublishRelay

final class EventListViewModel: ViewModelType {
    private let disposeBag = DisposeBag()
    private let repository: EventListRepository
    private let stateManager: DataStateManager
    
    weak var delegate: EventListDelegate?
    
    let input: EventListViewModel.Input
    let output: EventListViewModel.Output
    
    struct Input {
        let fetch = PublishRelay<Void>()
        let search = PublishRelay<String>()
        let selectedModel = PublishRelay<EventListItemViewModel>()
    }
    
    struct Output {
        let title = R.string.localizable.eventListTitle()
        var state: Driver<DataState>
        var endRefreshing: Driver<Void>
        var items: Driver<[EventListItemViewModel]>
    }
    
    init(dependencies: Dependencies) {
        let stateManager = DataStateManager()
        let repository = EventListRepository(networkingService: dependencies.networkingService)
        self.input = Input()
        
        let response = input.fetch
            .startWith(())
            .flatMapLatest { Self.executeFetchRequest(query: "", using: repository, stateHandler: stateManager).materialize() }
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
        
        setUp()
    }
    
    private func setUp() {
        input.selectedModel.subscribe(onNext: { [weak self] (item) in
            self?.delegate?.didSelect(item.event)
        }).disposed(by: disposeBag)
    }
    
    private static func executeFetchRequest(query: String, on page: Int? = nil, using repository: EventListRepository, stateHandler: DataStateManager) -> Observable<[EventListItemViewModel]> {
        return Observable.create { (observer) -> Disposable in
            stateHandler.update(.loading)
            
            repository.fetchEventList { (result) in
                switch result {
                case .success(let response):
                    stateHandler.update(response.events.isEmpty ? .empty("") : .loaded)
                    observer.onNext(response.events.map { EventListItemViewModel(with: $0) })
                    observer.onCompleted()
                case .failure(let error):
                    stateHandler.update(.error(error.localizedDescription))
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}

extension EventListViewModel: StateManaging, DataReloading {
    var currentState: Driver<DataState> {
        return output.state
    }
    
    func reloadData() {
        input.fetch.accept(())
    }
}

extension EventListViewModel {
    typealias Dependencies = HasNetworking
}
