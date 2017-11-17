//
//  MapViewController.swift
//  CarPool
//
//  Created by Naina  on 11/8/17.
//  Copyright © 2017 Riyazh. All rights reserved.
//

import UIKit
import MapKit
import CarpoolKit

class MapViewController: UIViewController, UISearchControllerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var trip: Trip!
    
    let locationManager = CLLocationManager()
    var selectedMapItem: MKMapItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        navigationController?.navigationBar.barTintColor = UIColor(red: 31/255, green: 39/255, blue: 144/255, alpha: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    @IBAction func onDirectionsPressed(_ sender: UIBarButtonItem) {
        //        let latitude: CLLocationDegrees = 37.2
        //        let longitude: CLLocationDegrees = 22.9
        
        //        if let longitude = selectedMapItem?.placemark.coordinate.longitude {
        //            if let latitude = selectedMapItem?.placemark.coordinate.latitude {
        //
        //                let regionDistance: CLLocationDistance = 10000
        //                let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        //                let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        //                let options = [
        //                    MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
        //                    MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        //                ]
        //                let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        //                let mapItem = MKMapItem(placemark: placemark)
        //                mapItem.name = "Place Name"
        //                mapItem.openInMaps(launchOptions: options)
        //            }
        //        }
        
        if let latitude = trip.event.clLocation?.coordinate.latitude {
            if let longitude = trip.event.clLocation?.coordinate.longitude {
                let regionDistance: CLLocationDistance = 10000
                let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
                let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
                let options = [
                    MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                    MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
                ]
                let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
                let mapItem = MKMapItem(placemark: placemark)
                mapItem.name = "Place Name"
                mapItem.openInMaps(launchOptions: options)
            }
        }
    }
    
    func search() {
        if let latitude = trip.event.clLocation?.coordinate.latitude {
            if let longitude = trip.event.clLocation?.coordinate.longitude {
                self.mapView.addAnnotation(trip.event.clLocation as! MKAnnotation)
//                self.mapView.addAnnotation(CLLocationCoordinate2D(latitude: latitude, longitude: longitude) as! MKAnnotation)
//                var placemark = CLPlacemark(placemark: )
            }
        }
        //        //self.mapView.addAnnotation(self.trip.event.clLocation.)
        //        self.mapView.addAnnotation((self.selectedMapItem?.placemark)!)
    }
}

extension MapViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if let latitude = trip.event.clLocation?.coordinate.latitude {
            if let longitude = trip.event.clLocation?.coordinate.longitude {
                let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
                let coordinateRegion = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 10000, 10000)
                mapView.setRegion(coordinateRegion, animated: true)
                let region = MKCoordinateRegion(center: (coordinates) , span: coordinateRegion.span)
                mapView.setRegion(region, animated: true)
                
                search()
            }
        }
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

extension CLLocation: MKAnnotation {
    
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
