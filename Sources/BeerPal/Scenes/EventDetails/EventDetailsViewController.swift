//
//  EventDetailsViewController.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 20.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit
import RxCocoa
import class RxSwift.DisposeBag
import class RxSwift.Observable

final class EventDetailsViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    private let shareButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: nil, action: nil)
    private var eventDetailsView: EventDetailsView!
    private let viewModel: EventDetailsViewModel
    private var urlToShare: URL?
    
    override func loadView() {
        eventDetailsView = EventDetailsView(using: viewModel.output.itemViewModel)
        view = eventDetailsView
    }
    
    init(viewModel: EventDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createBindings()
        navigationItem.rightBarButtonItem = shareButtonItem
    }
    
    private func createBindings() {
        Observable.merge([
            eventDetailsView.addressField.rx.tap.asObservable(),
            eventDetailsView.mapView.rx.tap.asObservable()
          ]).bind(to: viewModel.input.navigate)
            .disposed(by: disposeBag)
        
        eventDetailsView.phoneField?
            .rx.tap
            .bind(to: viewModel.input.call)
            .disposed(by: disposeBag)
        
        shareButtonItem
            .rx.tap
            .bind(to: viewModel.input.share)
            .disposed(by: disposeBag)
        
        viewModel.output.shareURL
            .filter { $0 != nil }
            .drive(onNext: { [weak self] (url) in
                self?.urlToShare = url
                self?.share()
            }).disposed(by: disposeBag)
    }
    
    private func share() {
        guard let url = urlToShare else { return }
        
        let activityController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
}

