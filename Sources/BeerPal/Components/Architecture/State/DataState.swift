//
//  DataState.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 31.08.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import RxCocoa
import UIKit

enum DataState: Equatable {
    case idle
    case loading
    case loaded
    case empty(_ message: String)
    case error(_ message: String)
}
