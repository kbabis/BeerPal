//
//  BeerColorHelper.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 29.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

struct BeerColorHelper {
    private let colorsInfo: [BeerColorInfo] = [
        BeerColorInfo(ebc: 4, srm: 2, color: UIColor(red: 248/255, green: 247/255, blue: 83/255, alpha: 1)),
        BeerColorInfo(ebc: 6, srm: 3, color: UIColor(red: 246/255, green: 245/255, blue: 19/255, alpha: 1)),
        BeerColorInfo(ebc: 8, srm: 4, color: UIColor(red: 236/255, green: 230/255, blue: 26/255, alpha: 1)),
        BeerColorInfo(ebc: 12, srm: 6, color: UIColor(red: 213/255, green: 188/255, blue: 38/255, alpha: 1)),
        BeerColorInfo(ebc: 16, srm: 8, color: UIColor(red: 191/255, green: 146/255, blue: 59/255, alpha: 1)),
        BeerColorInfo(ebc: 20, srm: 10, color: UIColor(red: 191/255, green: 129/255, blue: 58/255, alpha: 1)),
        BeerColorInfo(ebc: 26, srm: 13, color: UIColor(red: 188/255, green: 103/255, blue: 51/255, alpha: 1)),
        BeerColorInfo(ebc: 33, srm: 17, color: UIColor(red: 141/255, green: 76/255, blue: 50/255, alpha: 1)),
        BeerColorInfo(ebc: 39, srm: 20, color: UIColor(red: 93/255, green: 52/255, blue: 26/255, alpha: 1)),
        BeerColorInfo(ebc: 47, srm: 24, color: UIColor(red: 38/255, green: 23/255, blue: 22/255, alpha: 1)),
        BeerColorInfo(ebc: 57, srm: 29, color: UIColor(red: 15/255, green: 11/255, blue: 10/255, alpha: 1)),
        BeerColorInfo(ebc: 69, srm: 35, color: UIColor(red: 8/255, green: 7/255, blue: 7/255, alpha: 1)),
        BeerColorInfo(ebc: 79, srm: 40, color: UIColor(red: 3/255, green: 4/255, blue: 3/255, alpha: 1))
    ]
    
    func makeSRMColor(value: Double) -> UIColor? {
        let srmValues = colorsInfo.map { $0.srm }
        guard let index = getClosestIndex(to: value, in: srmValues) else { return nil }
        
        return colorsInfo[index].color
    }
    
    func makeEBCColor(value: Double) -> UIColor? {
        let ebcValues = colorsInfo.map { $0.ebc }
        guard let index = getClosestIndex(to: value, in: ebcValues) else { return nil }
    
        return colorsInfo[index].color
    }
    
    private func getClosestIndex(to value: Double, in array: [Double]) -> Int? {
        let closestElement = array.enumerated().min(by: { abs($0.1 - value) < abs($1.1 - value) } )
        return closestElement?.offset
    }
     
    struct BeerColorInfo {
        let ebc: Double
        let srm: Double
        let color: UIColor
    }
}
