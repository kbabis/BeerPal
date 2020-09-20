//
//  MapView.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 20.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import MapKit

final class MapView: MKMapView {
    func setFocusPoint(latitude: Double, longitude: Double) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        addAnnotation(annotation)
        
        setCenter(annotation.coordinate, animated: true)
    }
}
