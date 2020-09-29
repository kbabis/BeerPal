//
//  TableViewAnimationFactory.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 17.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

struct TableViewAnimationFactory {
    static func makeTopSlide(offset: CGFloat, duration: TimeInterval) -> TableViewAnimator.Animation {
        return { cell, indexPath, _  in
            cell.transform = CGAffineTransform(translationX: 0, y: offset)
            
            UIView.animate(
                withDuration: duration,
                delay: Double(indexPath.row) * 0.05,
                usingSpringWithDamping: 0.9,
                initialSpringVelocity: 0.3,
                options: [.curveEaseInOut],
                animations: {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
            })
        }
    }
}
