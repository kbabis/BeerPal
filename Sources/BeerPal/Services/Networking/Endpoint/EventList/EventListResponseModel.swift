//
//  EventListResponseModel.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 19.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

struct EventListResponseModel: Codable {
    let currentPage: Int
    let numberOfPages: Int
    let totalResults: Int
    let events: [Event]
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case currentPage, numberOfPages, totalResults, status
        case events = "data"
    }
}

struct Event: Codable {
    let id: String
    let year: String?
    let name: String
    let description: String?
    let type: EventType
    let typeDisplay: String
    @DecodableSpecialDate var startDate: Date?
    @DecodableSpecialDate var endDate: Date?
    let time: String?
    let price: String?
    let venueName: String
    let streetAddress: String
    let locality: String?
    let region: String
    let postalCode: String?
    let countryIsoCode: String
    let latitude, longitude: Double
    let website: String?
    let phone: String?
    let images: Images
    let status: Status
    let statusDisplay: String
    let createDate: Date
    let updateDate: Date
    let country: Country
    let extendedAddress: String?
    
    struct Country: Codable {
        let isoCode: String
        let name: String
        let displayName: String
        let isoThree: String
        let numberCode: Int
        let createDate: Date
    }

    struct Images: Codable {
        let icon, medium, large: String
    }

    enum Status: String, Codable {
        case verified = "verified"
    }
    
    enum EventType: String, Codable {
        case comboFestivalCompetition = "festival_competition"
        case competition
        case festival
        case meetup
        case other
        case seminar
        case tasting
        
        var displayedName: String {
            switch self {
            case .comboFestivalCompetition:
                return R.string.localizable.eventTypeComboFestivalCompetition()
            case .competition:
                return R.string.localizable.eventTypeCompetition()
            case .festival:
                return R.string.localizable.eventTypeFestival()
            case .meetup:
                return R.string.localizable.eventTypeMeetup()
            case .other:
                return R.string.localizable.eventTypeOther()
            case .seminar:
                return R.string.localizable.eventTypeSeminar()
            case .tasting:
                return R.string.localizable.eventTypeTasting()
            }
        }
    }
}
