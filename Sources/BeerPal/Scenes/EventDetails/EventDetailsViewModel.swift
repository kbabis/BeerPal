//
//  EventDetailsViewModel.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 20.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import Foundation
import RxSwift
import class RxCocoa.PublishRelay
import struct RxCocoa.Driver

final class EventDetailsViewModel: NSObject, ViewModelType {
    private let disposeBag = DisposeBag()
    
    let input: Input
    let output: Output
    
    struct Input {
        let navigate = PublishRelay<Void>()
        let call = PublishRelay<Void>()
        let share = PublishRelay<Void>()
    }
    
    struct Output {
        let itemViewModel: EventDetailsItemViewModel
        let shareURL: Driver<URL?>
    }
    
    init(from event: Event) {
        let itemViewModel = EventDetailsItemViewModel(from: event)
        self.input = Input()
        
        input.navigate
            .subscribe(onNext: { (_) in
                NavigationHelper.openMapsAppWithDirections(
                    to: event.venueName,
                    latitude: event.latitude,
                    longitude: event.longitude
                )
            }).disposed(by: disposeBag)
        
        input.call
            .subscribe(onNext: { (_) in
                PhoneCallHelper.call(event.phone)
            }).disposed(by: disposeBag)
        
        let shareURL = input.share
            .flatMapLatest { Observable.just(itemViewModel.websiteURL) }
            .asDriver(onErrorJustReturn: nil)
        
        self.output = Output(itemViewModel: itemViewModel, shareURL: shareURL)
    }
}
