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
    var selectedDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.minimumDate = Date()
        locationManager.delegate = self
        createTrip()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        datePicker.setDate(selectedDate, animated: true)
    }
    
    @IBAction func onDatePickerSelected(_ sender: UIDatePicker) {
        selectedDate = sender.date
    }
    
    func createTrip() {
        if nameOfEventTextField.text != nil {
            API.createTrip(eventDescription: nameOfEventTextField.text!, eventTime: datePicker.date, eventLocation: location) { (trip) in
                print(trip)
            }
        }
    }
}
