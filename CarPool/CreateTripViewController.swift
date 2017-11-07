//
//  CreateTripViewController.swift
//  CarPool
//
//  Copyright © 2017 Riyazh. All rights reserved.
//

import UIKit
import CarpoolKit
import CoreLocation

class CreateTripViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var nameOfEventTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let location = CLLocation()
    let locationManager = CLLocationManager()
    var locationOfEvent = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        createTrip()
    }
    
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func createTrip() {
//        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//            if let searchLocation = searchBar.text {
//                let geocoder = CLGeocoder()
//                geocoder.geocodeAddressString(searchLocation, completionHandler: { (placemark, error) in
//                    if let placemark = placemark {
//
//                    }
//                })
//            }
//        }
        API.createTrip(eventDescription: nameOfEventTextField.text!, eventTime: datePicker.date, eventLocation: location) { (trip) in
            print(trip)
        }
    }
}
