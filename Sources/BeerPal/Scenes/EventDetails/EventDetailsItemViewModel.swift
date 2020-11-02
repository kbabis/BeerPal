//
//  EventDetailsItemViewModel.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 20.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

struct EventDetailsItemViewModel {
    typealias LocationCoordinates = (latitude: Double, longitude: Double)
    
    private let event: Event
    
    var name: String { event.name }
    var imageURLString: String { event.images.large }
    var coordinates: LocationCoordinates { (latitude: event.latitude, longitude: event.longitude) }
    var dateInfo: String { makeDateInfo(for: event) }
    var fullAddress: String { makeFullAddress(for: event) }
    var priceFormatted: String? { event.price }
    var phoneNumber: String? { event.phone }
    var description: String? { event.description }
    var websiteURL: URL? { event.website?.urlValue }
    
    init(from event: Event) {
        self.event = event
    }
    
    private func makeFullAddress(for event: Event) -> String {
        var fullAddress = event.venueName
        fullAddress.appendLn(event.streetAddress)
        
        let regionInfo = [event.postalCode, event.locality, event.region].compactMap { $0 }.reduce("", { $0 == "" ? $1 : $0 + ", " + $1 })
        if !regionInfo.isEmpty { fullAddress.appendLn(regionInfo) }
        
        return fullAddress
    }
    
    private func makeDateInfo(for event: Event) -> String {
        var dateInfo = event.startDate?.presentableFormat ?? ""

        if !dateInfo.isEmpty, let endInfo = event.endDate?.presentableFormat {
            dateInfo.append(" - " + endInfo)
        }
        
        if let timeInfo = event.time {
            dateInfo.appendLn(timeInfo)
        }
        
        return dateInfo
    }
}

private extension String {
    var urlValue: URL? {
        return URL(string: self)
    }
}
