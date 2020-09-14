//
//  ViewModelType.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 14.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import RxCocoa

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    var input: Input { get }
    var output: Output { get }
}

protocol StatefulViewModelType: ViewModelType {
    var state: Driver<DataState> { get }
}
