//
//  EventListEndpoint.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 19.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

extension API {
    static func eventList() -> Endpoint<EventListResponseModel> {
        let url = URLBuilder()
        .set(path: "events")
        .addQueryItem(name: "hasImages", value: "Y")
        .build()!
        
        return Endpoint(method: .get, url: url)
    }
}
