//
//  BeerListRepository.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 09.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

final class BeerListRepository {
    typealias CompletionBlock = (Result<[Beer], Error>) -> Void
    
    private let networkingService: Networking
    private let cache: CacheWrapper<String, [Beer]>

    init(
        networkingService: Networking,
        cache: CacheWrapper<String, [Beer]> = CacheWrapper(base: Cache<String, [Beer]>(maximumEntryCount: 10))
    ) {
        self.networkingService = networkingService
        self.cache = cache
    }
    
    func fetchBeers(name: String? = nil, page: Int = 1, then handler: @escaping CompletionBlock) {
        let endpoint = API.beerList(name: name, at: page)
        let cacheKey = endpoint.url.absoluteString
        
        if let cached = cache[cacheKey] {
            return handler(.success(cached))
        }

        networkingService.request(endpoint, then: { [weak self] (result) in
            let beers = try? result.get()
            beers.map { self?.cache[cacheKey] = $0 }
            handler(result)
        })
    }
}
