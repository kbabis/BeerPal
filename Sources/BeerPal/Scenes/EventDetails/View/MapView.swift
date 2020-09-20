//
//  MapView.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 20.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import MapKit
import RxSwift
import struct RxCocoa.ControlEvent

final class MapView: MKMapView {
    private let overlayView = UIView()
    let fillButton = UIButton()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    func setFocusPoint(latitude: Double, longitude: Double) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        addAnnotation(annotation)
        
        setCenter(annotation.coordinate, animated: true)
    }
}

extension MapView {
    private func setUp() {
        setUpFillButton()
        setUpOverlayView()
        animateOverlayDisappearing()
    }
    
    private func setUpFillButton() {
        addSubview(fillButton)
        
        fillButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func setUpOverlayView() {
        overlayView.backgroundColor = .black
        addSubview(overlayView)
        
        overlayView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func animateOverlayDisappearing() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.7) { [weak self] in
                self?.overlayView.alpha = 0
            }
        }
    }
}

extension Reactive where Base: MapView {
    var tap: ControlEvent<Void> {
        return base.fillButton.rx.tap
    }
}
