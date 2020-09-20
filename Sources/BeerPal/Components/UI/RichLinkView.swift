//
//  RichLinkView.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 20.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit
import LinkPresentation

@available(iOS 13.0, *)
final class RichLinkView: UIView {
    private var provider = LPMetadataProvider()
    private var linkView = LPLinkView()
    
    func loadURL(_ url: URL) {
        provider = LPMetadataProvider()
        provider.timeout = 5
        
        linkView.removeFromSuperview()
        addLinkView(url: url)
        
        fetchMetadata(for: url)
    }
    
    private func fetchMetadata(for url: URL) {
        provider.startFetchingMetadata(for: url) { metadata, _ in
            guard let metadata = metadata else { return }
            
            DispatchQueue.main.async { [weak self] in
                self?.linkView.metadata = metadata
            }
        }
    }
}

@available(iOS 13.0, *)
extension RichLinkView {
    private func addLinkView(url: URL) {
        linkView = LPLinkView(url: url)
        addSubview(linkView)
        
        linkView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
