//
//  MockCache.swift
//  BeerPalTests
//
//  Created by Krzysztof Babis on 09.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

@testable import BeerPal

final class MockCache<T: Hashable, Value>: Caching {
    typealias Key = T
    typealias Value = Value
    
    private var store = [T: Value]()
    
    func insert(_ value: Value, forKey key: T) {
        store[key] = value
    }
    
    func value(forKey key: T) -> Value? {
        return store[key]
    }
    
    func removeValue(forKey key: T) {
        store.removeValue(forKey: key)
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
