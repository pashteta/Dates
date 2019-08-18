//
//  mapViewImage.swift
//  Deals
//
//  Created by admin on 7/31/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import MapKit

class MapViewImage {
    
    //add information about restaurant on map
    static  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        let annotationIdentifier = "restAnnotation"
        //  похожий принцип как с ячейками
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.canShowCallout = true
        }
        
        // let rightImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        //rightImage.image = UIImage(data: meets.image! as Data)
        //annotationView?.rightCalloutAccessoryView = rightImage
        annotationView?.pinTintColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
        
        return annotationView
    }
    
}
