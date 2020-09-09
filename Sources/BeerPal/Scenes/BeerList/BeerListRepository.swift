//
//  BeerListRepository.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 09.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

final class BeerListRepository {
    typealias CompletionBlock = (Result<BeerListResponseModel, Error>) -> Void
    
    private let networkingService: Networking
    private let cache: CacheWrapper<String, BeerListResponseModel>

    init(
        networkingService: Networking,
        cache: CacheWrapper<String, BeerListResponseModel> = CacheWrapper(base: Cache<String, BeerListResponseModel>(maximumEntryCount: 1))
    ) {
        self.networkingService = networkingService
        self.cache = cache
    }
    
    func fetchBeers(then handler: @escaping CompletionBlock) {
        let cacheKey: String = "LatestBeerResponseModel"
        
        if let cached = cache[cacheKey] {
            return handler(.success(cached))
        }

        networkingService.request(API.beers(), then: { [weak self] (result) in
            let beers = try? result.get()
            beers.map { self?.cache[cacheKey] = $0 }
            handler(result)
        })
    }
}
