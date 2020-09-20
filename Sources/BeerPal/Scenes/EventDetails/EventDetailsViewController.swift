//
//  EventDetailsViewController.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 20.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class EventDetailsViewController: UIViewController {
    private var eventDetailsView: EventDetailsView!
    private let viewModel: EventDetailsViewModel
    
    override func loadView() {
        eventDetailsView = EventDetailsView(using: viewModel)
        view = eventDetailsView
    }
    
    init(viewModel: EventDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
}
