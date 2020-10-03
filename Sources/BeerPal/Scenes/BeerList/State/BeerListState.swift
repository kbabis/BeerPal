//
//  BeerListState.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 03.10.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import RxCocoa

struct BeerListState {
    private var nextPage: Int
    private var phraseToSearch: String?
    var shouldLoadNext: Bool
    var items: [BeerListItemViewModel]
    var error: Error?

    init() {
        self.items = []
        self.nextPage = 1
        self.shouldLoadNext = true
    }

    typealias Feedback = (Driver<BeerListState>) -> Signal<BeerListEvent>
}

extension BeerListState {
    var nextPageData: QueryItems? {
        return shouldLoadNext
            ? .init(searchPhrase: phraseToSearch, pageIndex: nextPage)
            : nil
    }
    
    struct QueryItems: Equatable {
        let searchPhrase: String?
        let pageIndex: Int?
    }
}

extension BeerListState {
    static func reduce(state: BeerListState, event: BeerListEvent) -> BeerListState {
        var newState = state
        
        switch event {
        case .loadNextPage:
            newState.shouldLoadNext = true
        case .handleResponse(.failure(let error)):
            newState.shouldLoadNext = false
            newState.error = error
        case .handleResponse(.success(let beers)):
            newState.shouldLoadNext = false
            newState.error = nil
            newState.nextPage += 1
            newState.items += beers.map(BeerListItemViewModel.init)
        case .reload:
            newState = BeerListState()
        case .search(let phrase):
            newState = BeerListState()
            newState.phraseToSearch = phrase.isEmpty ? nil : phrase
        }
        
        return newState
    }
}
