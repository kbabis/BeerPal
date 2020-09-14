//
//  URLBuilder.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 27.08.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

final class URLBuilder {
    private var components: URLComponents
    private let version: String?

    init(scheme: String = "https", host: String = AppConfig.API.host, version: String? = AppConfig.API.version) {
        self.components = URLComponents()
        self.components.scheme = scheme
        self.components.host = host
        self.version = version
    }

    func set(port: Int) -> URLBuilder {
        components.port = port
        return self
    }

    func set(path: String) -> URLBuilder {
        var fullPath = ""

        if let version = version {
            fullPath.appendPathComponent(version)
        }
        
        fullPath.appendPathComponent(path)
        components.path = fullPath
        return self
    }

    func addQueryItem(name: String, value: String) -> URLBuilder {
        if components.queryItems == nil {
            components.queryItems = []
        }
        components.queryItems?.append(URLQueryItem(name: name, value: value))
        return self
    }

    func build() -> URL? {
        return components.url
    }
}

private extension String {
    mutating func appendPathComponent(_ component: String) {
        guard !component.isEmpty else { return }
        
        if !component.hasPrefix("/") {
            append("/")
        }
        append(component)
    }
}
