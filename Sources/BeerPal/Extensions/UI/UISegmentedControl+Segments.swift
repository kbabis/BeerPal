//
//  UISegmentedControl+Segments.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 14.10.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import class UIKit.UISegmentedControl

extension UISegmentedControl {
    func setSegments(_ segments: [String], animated: Bool = false) {
        removeAllSegments()
        
        for segment in segments {
            insertSegment(withTitle: segment, at: numberOfSegments, animated: animated)
        }
    }
}
