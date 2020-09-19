//
//  EventListView.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 19.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class EventListView: UIView {
    let tableView = UITableView()
    let refreshControl = UIRefreshControl()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    private func setUp() {
        backgroundColor = Theme.Colors.Background.primary
        setUpTableView()
        setUpRefreshControl()
    }
    
    private func setUpTableView() {
        addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func setUpRefreshControl() {
        tableView.refreshControl = refreshControl
    }
}
