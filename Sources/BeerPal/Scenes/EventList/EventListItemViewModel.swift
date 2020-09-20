//
//  EventListItemViewModel.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 19.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class EventListItemViewModel {
    let event: Event
    
    var id: String { event.id }
    var name: String { event.name }
    var imageURLString: String { event.images.medium }
    var date: String { event.startDate?.presentableFormat ?? "" }
    var address: String { String(format: "%@, %@", (event.locality ?? event.region), event.country.displayName) }
    var tags: [Tag] {
        return [
            (name: event.type.displayedName, color: .systemBlue),
            (name: event.statusDisplay, color: .systemGreen)
        ]
    }
    
    init(with event: Event) {
        self.event = event
    }
}

extension EventListItemViewModel {
    typealias Tag = (name: String, color: UIColor)
}
