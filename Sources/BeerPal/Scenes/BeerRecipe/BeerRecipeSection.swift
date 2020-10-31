//
//  BeerRecipeSection.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 23.10.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import RxDataSources

struct BeerRecipeSection {
    typealias Model = SectionModel<String, BeerRecipeItem>
    
    var header: String
    var items: [BeerRecipeItem]
}

extension BeerRecipeSection: SectionModelType {
    typealias Item = BeerRecipeItem
    
    init(original: BeerRecipeSection, items: [BeerRecipeItem]) {
        self = original
        self.items = items
    }
}
