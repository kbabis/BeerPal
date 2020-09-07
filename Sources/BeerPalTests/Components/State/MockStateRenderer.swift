//
//  MockStateRenderer.swift
//  BeerPalTests
//
//  Created by Krzysztof Babis on 08.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

@testable import BeerPal

final class MockStateRenderer: StateRendering {
    var emptyStateRendersCount = 0
    var errorStateRendersCount = 0
    var idleStateRendersCount = 0
    var loadedStateRendersCount = 0
    var loadingStateRendersCount = 0
    
    func render(_ state: DataState) {
        switch state {
        case .idle:
            idleStateRendersCount += 1
        case .empty(_):
            emptyStateRendersCount += 1
        case .error(_):
            errorStateRendersCount += 1
        case .loaded:
            loadedStateRendersCount += 1
        case .loading:
            loadingStateRendersCount += 1
        }
    }
}
