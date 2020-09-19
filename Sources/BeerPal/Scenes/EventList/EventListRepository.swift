//
//  EventListRepository.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 19.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

final class EventListRepository {
    typealias CompletionBlock = (Result<EventListResponseModel, Error>) -> Void
    
    private let networkingService: Networking
    private let cache: CacheWrapper<String, EventListResponseModel>

    init(
        networkingService: Networking,
        cache: CacheWrapper<String, EventListResponseModel> = CacheWrapper(base: Cache<String, EventListResponseModel>(maximumEntryCount: 1))
    ) {
        self.networkingService = networkingService
        self.cache = cache
    }
    
    func fetchEventList(then handler: @escaping CompletionBlock) {
        let endpoint = API.eventList()
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
