//
//  UIImageView+Nuke.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 12.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit
import Nuke

extension UIImageView {
    enum ImageSize: CGFloat {
        case small = 25
        case medium = 50
        case big = 100
    }
    
    func loadImage(from url: URL, size: ImageSize = .medium) {
        let request = ImageRequest(url: url, processors: [
            ImageProcessors.Resize(size: .init(width: size.rawValue, height: size.rawValue)),
            ImageProcessors.Circle()
        ])
        
        let options = ImageLoadingOptions(transition: .fadeIn(duration: 0.5))
        
        Nuke.loadImage(with: request, options: options, into: self)
    }
    
    func loadImage(from urlString: String?, size: ImageSize = .medium) {
        guard let urlString = urlString, let imageURL = URL(string: urlString) else { return }
        
        loadImage(from: imageURL, size: size)
    }
}
