//
//  EventListItemViewModel.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 19.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class EventListItemViewModel {
    private let event: Event
    
    var id: String { return event.id }
    var name: String { return event.name }
    var imageURLString: String { return event.images.medium }
    var date: String { return prepareDisplayableDate(from: event.startDate) }
    var address: String { return String(format: "%@, %@", (event.locality ?? event.region), event.country.displayName) }
    var tags: [Tag] {
        return [
            (name: event.type.displayedName, color: .systemBlue),
            (name: event.statusDisplay, color: .systemGreen)
        ]
    }
    
    init(with event: Event) {
        self.event = event
    }
    
    private func prepareDisplayableDate(from date: Date?) -> String {
        guard let date = date else { return "" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter.string(from: date)
    }
}

extension EventListItemViewModel {
    typealias Tag = (name: String, color: UIColor)
}
