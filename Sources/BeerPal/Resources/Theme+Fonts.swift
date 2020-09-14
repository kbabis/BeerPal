//
//  Theme+Fonts.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 07.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

extension Theme {
    enum Fonts {
        enum TextSize: CGFloat {
            case xxSmall = 10.0
            case xSmall = 12.0
            case small = 14.0
            case medium = 16.0
            case large = 18.0
            case xLarge = 20.0
        }
        
        static func getFont(ofSize size: TextSize, weight: UIFont.Weight) -> UIFont {
            return UIFont.systemFont(ofSize: size.rawValue, weight: weight)
        }
    }
}
