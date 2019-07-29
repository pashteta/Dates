//
//  MapViewController.swift
//  Deals
//
//  Created by admin on 7/28/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    var meets: Meets?

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        //деокодирует из текстового в широту и долготу и наоборот
        let geocoder = CLGeocoder()
        //placemark - массив адрессов и массив ошибок
    
        geocoder.geocodeAddressString(meets?.place ?? "square") { (placemarks, error) in
            //если ошибок нет, то мы дальше работаем
            guard error == nil else { return }
            //извлекаем наш масссив
            guard let placemarks = placemarks else { return }
            
            //получаем из массива адрессов 1 элемент этого масссива
            let placemark = placemarks.first!
            
            //делаем марку на нашей карте
            let annotation = MKPointAnnotation()
            annotation.title = self.meets?.name
            //annotation.subtitle = self.restaurant.type
            
            //координаты нашего ресторана
            guard let location = placemark.location else { return }
            //если мы узнали координаты то мы должны разместить марку на некоторых координатах
            annotation.coordinate = location.coordinate
            
            self.mapView.showAnnotations([annotation], animated: true)
            //хотим развернуть нашу анотацию
            self.mapView.selectAnnotation(annotation, animated: true)
            
        }
        
    }
 
    //add information about restaurant on map
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
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
