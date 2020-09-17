//
//  PopUpView.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 17.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class PopUpView: UIView {
    private let messageLabel = PopUpMessageLabel()
    private weak var timer: Timer?
    private let config: Config
    
    var afterHidingAction: (() -> Void)?
    
    init(config: PopUpView.Config = .init()) {
        self.config = config
        super.init(frame: .zero)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Init:coder is not supported")
    }
    
    deinit { timer?.invalidate() }
    
    func show(_ message: String) {
        messageLabel.text = message
        setVisibility(true)
    }
    
    @objc
    func hide() {
        setVisibility(false, then: afterHidingAction)
    }
}

extension PopUpView {
    private func setUp() {
        setUpMessageLabel()
        if config.hidesOnInteraction {
            setUpTapGestureRecognizer()
        }
        
        backgroundColor = .systemRed
        alpha = 0
    }
    
    private func setUpMessageLabel() {
        addSubview(messageLabel)
        
        messageLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(12)
            make.right.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(12)
        }
    }
    
    private func setUpTapGestureRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hide))
        addGestureRecognizer(tapRecognizer)
    }
    
    private func setVisibility(_ isVisible: Bool, then completion: (() -> Void)? = nil) {
        let alpha: CGFloat = isVisible ? 1 : 0
        let curve: UIView.AnimationCurve = isVisible ? .easeIn : .easeOut
        
        let animator = UIViewPropertyAnimator(duration: config.animationDuration, curve: curve) { [weak self] in
            self?.alpha = alpha
        }
        
        animator.addCompletion { (position) in
            if position == .end { completion?() }
        }
        
        animator.startAnimation()
        
        guard config.hidesAutomatically else { return }
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(
            timeInterval: config.displayDuration,
            target: self,
            selector: #selector(hide),
            userInfo: nil,
            repeats: false
        )
    }
}

extension PopUpView {
    struct Config {
        var hidesAutomatically = true
        var hidesOnInteraction = true
        var animationDuration: TimeInterval = 0.2
        var displayDuration: TimeInterval = 5.0
    }
}

private class PopUpMessageLabel: ExtendableLabel {
    override func setUp() {
        textAlignment = .center
        font = Theme.Fonts.getFont(ofSize: .small, weight: .semibold)
        textColor = .white
    }
}
