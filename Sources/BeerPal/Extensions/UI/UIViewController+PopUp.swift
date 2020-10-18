//
//  UIViewController+PopUp.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 17.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import class UIKit.UIViewController

extension UIViewController {
    func showPopUp(_ message: String) {
        let popUp = PopUpView()
        
        view.addSubview(popUp)
        popUp.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        popUp.afterHidingAction = {
            popUp.removeFromSuperview()
        }
        
        popUp.show(message)
    }
}
