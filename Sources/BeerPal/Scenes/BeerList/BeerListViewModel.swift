//
//  BeerListViewModel.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 24.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import RxCocoa
import RxSwift
import RxFeedback

final class BeerListViewModel: ViewModelType {
    private let disposeBag = DisposeBag()
    private let stateRelay = BehaviorRelay<BeerListState>(value: .init())
    private let repository: BeerListRepository
    weak var delegate: BeerListDelegate?
    
    let input: BeerListViewModel.Input
    let output: BeerListViewModel.Output
    
    struct Input {
        let events: PublishRelay<BeerListEvent> = PublishRelay()
        let selectedModel = PublishRelay<BeerListItemViewModel>()
    }
    
    struct Output {
        let title = R.string.localizable.beerListTitle()
        var state: Driver<BeerListState>
    }
    
    init(dependencies: Dependencies) {
        let repository = BeerListRepository(networkingService: dependencies.networkingService)
        self.repository = repository
        self.input = Input()
        self.output = Output(state: stateRelay.asDriver())
        
        let inputFeedback: BeerListState.Feedback = bind(self) { viewModel, _ in
            return Bindings(subscriptions: [], events: [viewModel.input.events.asSignal()])
        }
        
        let nextPageFeedback: BeerListState.Feedback = react(
            request: { $0.nextPageData },
            effects: { (queryItems) in
                Self.executeFetchRequest(query: queryItems.searchPhrase, on: queryItems.pageIndex, using: repository)
                    .asSignal(onErrorJustReturn: .failure(CustomError.unknown))
                    .map { BeerListEvent.handleResponse($0) }
            }
        )
        
        Driver.system(
            initialState: BeerListState(),
            reduce: BeerListState.reduce,
            feedback: inputFeedback, nextPageFeedback
        ).drive(stateRelay)
        .disposed(by: disposeBag)
        
        setUp()
    }
    
    private func setUp() {
        input.selectedModel.subscribe(onNext: { [weak self] (item) in
            self?.delegate?.didSelect(item.beer)
        }).disposed(by: disposeBag)
    }
    
    private static func executeFetchRequest(query: String?, on page: Int?, using repository: BeerListRepository) -> Observable<Result<[Beer], Error>> {
        return Observable.create { (observer) -> Disposable in
            repository.fetchBeers(name: query, page: page, then: { (result) in
                observer.onNext(result)
                observer.onCompleted()
            })
            
            return Disposables.create()
        }
    }
}

extension BeerListViewModel: DataReloading {
    func reloadData() {
        input
            .events
            .accept(.reload)
    }
}

extension BeerListViewModel {
    typealias Dependencies = HasNetworking
}

// Temporary solution - errors will be handled properly in the next phase
enum CustomError: Error {
    case unknown
}
