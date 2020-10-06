//
//  BreweryListResponseModel.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 11.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

struct BreweryListResponseModel: Codable {
    let currentPage: Int
    let numberOfPages: Int
    let totalResults: Int
    let breweries: [Brewery]
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case currentPage, numberOfPages, totalResults, status
        case breweries = "data"
    }
}

struct Brewery: Codable {
    let id, name, nameShortDisplay: String
    let description: String?
    let website: String?
    let established: String?
    let images: Images?
    let status: Status
    let statusDisplay: String
    let createDate: Date
    let updateDate: Date
    let locations: [Location]
    let mailingListUrl: String?
    @DecodableBool var isOrganic: Bool
    @DecodableBool var isMassOwned: Bool
    @DecodableBool var isInBusiness: Bool
    @DecodableBool var isVerified: Bool
    
    struct Images: Codable {
        let icon, medium, large: String
        let squareMedium, squareLarge: String
    }
    
    enum Status: String, Codable {
        case unverified = "new_unverified"
        case verified
        case deleted
    }
    
    struct Location: Codable {
        let id: String
        let name: String
        let streetAddress: String
        let locality: String
        let region: String
        let postalCode: String
        let country: Country
        let extendedAddress: String?
        let phone: String?
        let website: String?
        let latitude: Double
        let longitude: Double
        let locationType: String
        let locationTypeDisplay: String
        let countryIsoCode: String
        let yearOpened: String?
        let status: Status
        let statusDisplay: String
        let createDate: Date
        let updateDate: Date
        let hoursOfOperationExplicit: OpenHoursWeek?
        let hoursOfOperationExplicitString: String?
        let hoursOfOperationNotes: String?
        let timezoneId: String?
        @DecodableBool var isPrimary: Bool
        @DecodableBool var inPlanning: Bool
        @DecodableBool var isClosed: Bool
        @DecodableBool var openToPublic: Bool
        
        struct Country: Codable {
            let isoCode: String
            let name: String
            let displayName: String
            let isoThree: String
            let numberCode: Int
            let createDate: Date
        }
        
        struct OpenHoursWeek: Codable {
            let mon, tue, wed, thu, fri, sat, sun: [OpenHours]?
        }

        struct OpenHours: Codable {
            let startTime: String
            let endTime: String
        }
    }
}
