//
//  CacheWrapper.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 09.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

final class CacheWrapper<K: Hashable, V>: Caching {
    typealias Key = K
    typealias Value = V
    
    private let insertAction: (Value, Key) -> Void
    private let getAction: (Key) -> Value?
    private let removeAction: (Key) -> Void
    
    init<Cache: Caching>(base: Cache) where Cache.Key == K, Cache.Value == V {
        self.insertAction = cache.insert
        self.getAction = cache.value
        self.removeAction = cache.removeValue
    }
    
    func insert(_ value: Value, forKey key: Key) {
        insertAction(value, key)
    }
    
    func value(forKey key: Key) -> Value? {
        getAction(key)
    }
    
    func removeValue(forKey key: Key) {
        removeAction(key)
    }
    
    subscript(key: Key) -> Value? {
        get {
            value(forKey: key)
        }
        set {
            guard let value = newValue else {
                removeValue(forKey: key)
                return
            }

            insert(value, forKey: key)
        }
    }
}
