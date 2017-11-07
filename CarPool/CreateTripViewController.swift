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
    
    func createTrip() {
        if nameOfEventTextField.text != nil {
            API.createTrip(eventDescription: nameOfEventTextField.text!, eventTime: datePicker.date, eventLocation: location) { (trip) in
                print(trip)
            }
        }
    }
}
