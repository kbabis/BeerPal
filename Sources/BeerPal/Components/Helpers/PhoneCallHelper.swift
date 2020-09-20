//
//  PhoneCallHelper.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 20.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit.UIApplication

struct PhoneCallHelper {
    static func call(_ phoneNumber: String?) {
        guard
            let phoneNumber = phoneNumber,
            let url = URL(string: "tel://" + phoneNumber),
            UIApplication.shared.canOpenURL(url)
        else { return }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
