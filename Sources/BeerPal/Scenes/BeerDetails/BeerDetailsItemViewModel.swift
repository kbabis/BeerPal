//
//  BeerDetailsItemViewModel.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 24.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation
import class UIKit.UIColor

struct BeerDetailsItemViewModel {
    private let beer: Beer
    
    var name: String { beer.name }
    var tagline: String { beer.tagline.replacingOccurrences(of: ".", with: "") }
    var abv: String { beer.abv.stringValue.replacingOccurrences(of: ".", with: ",") }
    var gravity: String { beer.targetFg?.stringValue ?? "?" }
    var bitterness: String? { beer.ibu?.intValue.stringValue }
    var colorInfo: ColorInfo? { makeColorInfo(for: beer) }
    var description: String { beer.description }
    var imageURL: String? { beer.imageUrl }
    
    private func makeColorInfo(for beer: Beer) -> ColorInfo? {
        let helper = BeerColorHelper()
        
        if let ebc = beer.ebc, let color = helper.makeEBCColor(value: ebc) {
            return ColorInfo(
                type: .ebc, value:
                ebc.intValue.stringValue,
                color: color)
        } else if let srm = beer.srm, let color = helper.makeSRMColor(value: srm) {
            return ColorInfo(
                type: .srm,
                value: srm.intValue.stringValue,
                color: color)
        } else {
            return nil
        }
    }
    
    init(from beer: Beer) {
        self.beer = beer
    }
}

extension BeerDetailsItemViewModel {
    struct ColorInfo {
        let type: ScaleType
        let value: String
        let color: UIColor
        
        enum ScaleType: String {
            case ebc, srm
        }
    }
}

private extension Double {
    var stringValue: String {
        return String(self)
    }
    
    var intValue: Int {
        return Int(self)
    }
}

private extension Int {
    var stringValue: String {
        return String(self)
    }
}
