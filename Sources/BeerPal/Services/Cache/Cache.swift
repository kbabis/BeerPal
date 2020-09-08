//
//  Cache.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 09.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

final class Cache<Key: Hashable, Value> {
    private let store = NSCache<CachableKey, CachableObject>()
    private let keyTracker = KeyManager()
    private let entryLifetime: TimeInterval

    init(entryLifetime: TimeInterval = 12 * 60 * 60,
         maximumEntryCount: Int = 50) {
        self.entryLifetime = entryLifetime
        store.countLimit = maximumEntryCount
        store.delegate = keyTracker
    }
}

extension Cache: Caching {
    func insert(_ value: Value, forKey key: Key) {
        let date = Date().addingTimeInterval(entryLifetime)
        let entry = CachableObject(key: key, value: value, expirationDate: date)
        store.setObject(entry, forKey: CachableKey(from: key))
        keyTracker.keys.insert(key)
    }

    func value(forKey key: Key) -> Value? {
        guard let entry = store.object(forKey: CachableKey(from: key)) else {
            return nil
        }

        guard entry.expirationDate > Date() else {
            removeValue(forKey: key)
            return nil
        }

        return entry.value
    }

    func removeValue(forKey key: Key) {
        store.removeObject(forKey: CachableKey(from: key))
    }
    
    subscript(key: Key) -> Value? {
        get { return value(forKey: key) }
        
        set {
            guard let value = newValue else {
                removeValue(forKey: key)
                return
            }

            insert(value, forKey: key)
        }
    }
}

private extension Cache {
    final class CachableKey: NSObject {
        let key: Key

        init(from key: Key) { self.key = key }

        override var hash: Int { return key.hashValue }

        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? CachableKey else {
                return false
            }

            return value.key == key
        }
    }

    final class CachableObject {
        let key: Key
        let value: Value
        let expirationDate: Date

        init(key: Key, value: Value, expirationDate: Date) {
            self.key = key
            self.value = value
            self.expirationDate = expirationDate
        }
    }

    final class KeyManager: NSObject, NSCacheDelegate {
        var keys = Set<Key>()

        func cache(_ cache: NSCache<AnyObject, AnyObject>,
                   willEvictObject object: Any) {
            guard let entry = object as? CachableObject else {
                return
            }

            keys.remove(entry.key)
        }
    }
}
