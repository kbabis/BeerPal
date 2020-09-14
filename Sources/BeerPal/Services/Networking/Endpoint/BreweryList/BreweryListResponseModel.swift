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
        case verified = "verified"
    }
}
