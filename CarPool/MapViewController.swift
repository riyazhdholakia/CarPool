//
//  MapViewController.swift
//  CarPool
//
//  Created by Naina  on 11/8/17.
//  Copyright © 2017 Riyazh. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func search(for query: String)  {
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = query
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            if let response = response {
                //                print(response.mapItems)
                self.mapView.addAnnotations(response.mapItems)
                //                for mapItem in response.mapItems{
                //                    print(mapItem.placemark.title,mapItem.placemark.subtitle)
                //                    self.mapView.addAnnotation(mapItem.placemark)
                //                }
            }
        }
    }

}


extension MapViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 10000, 10000)
        mapView.setRegion(coordinateRegion, animated: true)
        
        search(for: "pizza")
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else { return }
        mapView.showsUserLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension MKMapItem: MKAnnotation {
    public var coordinate: CLLocationCoordinate2D {
        return placemark.coordinate
    }
    
    public var title: String?{
        return name
    }
    
    public var subTitle: String? {
        return phoneNumber
    }
}

