//
//  BeerListResponseModel.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 09.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation

struct BeerListResponseModel: Codable {
    let currentPage: Int
    let numberOfPages: Int
    let totalResults: Int
    let data: [Beer]
    let status: String
}

struct Beer: Codable {
    let id, name, nameDisplay: String
    let alcoholByVolume: String?
    let glasswareID, styleID: Int?
    @DecodableBool var isOrganic: Bool
    @DecodableBool var isRetired: Bool
    let images: Images?
    let status: VerificationStatus
    let statusDisplay: String
    let createDate: Date?
    let updateDate: Date?
    let glass: Glass?
    let style: BeerStyle?
    let description, ibu, originalGravity: String?
    let availableID: Int?
    let foodPairings: String?
    let available: AvailabilityInfo?
    let year: Int?
    let colorIntensityID: Int?
    let colorIntensity: ColorIntensity?
    let servingTemperature: String?
    let servingTemperatureDisplay: String?

    enum CodingKeys: String, CodingKey {
        case id, name, nameDisplay
        case alcoholByVolume = "abv"
        case glasswareID = "glasswareId"
        case styleID = "styleId"
        case isOrganic, isRetired
        case images = "labels"
        case status, statusDisplay, createDate, updateDate, glass, style, description, ibu, originalGravity
        case availableID = "availableId"
        case foodPairings, available, year
        case colorIntensityID = "srmId"
        case colorIntensity = "srm"
        case servingTemperature, servingTemperatureDisplay
    }
}

extension Beer {
    enum VerificationStatus: String, Codable {
        case verified
    }

    struct AvailabilityInfo: Codable {
        let id: Int
        let name: String
        let description: String
    }

    struct Glass: Codable {
        let id: Int
        let name: String
        let createDate: Date
    }

    struct Images: Codable {
        let icon: String
        let medium: String
        let large: String
        let contentAwareIcon: String
        let contentAwareMedium: String
        let contentAwareLarge: String?
    }

    struct ColorIntensity: Codable {
        let id: Int
        let name: String
        let hex: String
    }

    struct BeerStyle: Codable {
        let id, categoryID: Int
        let category: Glass
        let name, shortName, description: String
        let ibuMin, ibuMax, abvMin, abvMax: String?
        let srmMin, srmMax, ogMin, fgMin: String?
        let fgMax: String?
        let createDate: Date
        let updateDate, ogMax: String?

        enum CodingKeys: String, CodingKey {
            case id
            case categoryID = "categoryId"
            case category, name, shortName, description, ibuMin, ibuMax, abvMin, abvMax, srmMin, srmMax, ogMin, fgMin, fgMax, createDate, updateDate, ogMax
        }
    }
}
