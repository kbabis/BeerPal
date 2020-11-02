//
//  UIImageView+Nuke.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 12.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import class UIKit.UIImageView
import Nuke

extension UIImageView {
    func loadImage(from urlString: String?, estimatedSize: CGSize? = nil) {
        guard let urlString = urlString, let imageURL = URL(string: urlString) else { return }
        
        loadImage(from: imageURL, estimatedSize: estimatedSize, isCircular: false)
    }
    
    func loadCircularImage(from urlString: String?, estimatedSize: CGSize = .init(width: 50, height: 50)) {
        guard let urlString = urlString, let imageURL = URL(string: urlString) else { return }
        
        loadImage(from: imageURL, estimatedSize: estimatedSize, isCircular: true)
    }
    
    private func loadImage(from url: URL, estimatedSize: CGSize? = nil, isCircular: Bool) {
        var processors = [ImageProcessing]()
        
        if let size = estimatedSize { processors.append(ImageProcessors.Resize(size: size)) }
        if isCircular { processors.append(ImageProcessors.Circle()) }
        
        let request = ImageRequest(url: url, processors: processors)
        let options = ImageLoadingOptions(transition: .fadeIn(duration: 0.3))
        
        Nuke.loadImage(with: request, options: options, into: self)
    }
}
