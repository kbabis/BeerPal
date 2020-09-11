//
//  BreweryListRepository.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 11.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

final class BreweryListRepository {
    typealias CompletionBlock = (Result<BreweryListResponseModel, Error>) -> Void
    
    private let networkingService: Networking
    private let cache: CacheWrapper<String, BreweryListResponseModel>

    init(
        networkingService: Networking,
        cache: CacheWrapper<String, BreweryListResponseModel> = CacheWrapper(base: Cache<String, BreweryListResponseModel>(maximumEntryCount: 1))
    ) {
        self.networkingService = networkingService
        self.cache = cache
    }
    
    func fetchBreweryList(then handler: @escaping CompletionBlock) {
        let endpoint = API.breweryList()
        let cacheKey = endpoint.url.absoluteString
        
        if let cached = cache[cacheKey] {
            return handler(.success(cached))
        }

        networkingService.request(endpoint, then: { [weak self] (result) in
            let breweries = try? result.get()
            breweries.map { self?.cache[cacheKey] = $0 }
            handler(result)
        })
    }
}
