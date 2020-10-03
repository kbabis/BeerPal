//
//  BeerListState.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 03.10.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import RxCocoa

struct BeerListState {
    var items: [BeerListItemViewModel]
    var nextPage: Int
    var shouldLoadNext: Bool
    var phraseToSearch: String?

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
        case .error:
            newState.shouldLoadNext = false
        case .handleLoaded(let beers):
            newState.shouldLoadNext = false
            newState.nextPage += 1
            newState.items += beers
        case .reload:
            newState = BeerListState()
        case .search(let phrase):
            newState = BeerListState()
            newState.phraseToSearch = phrase.isEmpty ? nil : phrase
        }
        
        return newState
    }
}
