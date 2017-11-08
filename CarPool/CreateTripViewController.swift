//
//  CreateTripViewController.swift
//  CarPool
//
//  Copyright © 2017 Riyazh. All rights reserved.
//

import UIKit
import CarpoolKit
import CoreLocation
import MapKit

class CreateTripViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var nameOfEventTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var commentsTextField: UITextField!
    @IBOutlet weak var searchBarForLocation: UISearchBar!
    @IBOutlet weak var seeLocationOnAMapButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    
    let location = CLLocation()
    let locationManager = CLLocationManager()
    var locationOfEvent = ""
    var selectedDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.minimumDate = Date()
        locationManager.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        datePicker.setDate(selectedDate, animated: true)
    }
    
    @IBAction func onDatePickerSelected(_ sender: UIDatePicker) {
        selectedDate = sender.date
    }
    
    @IBAction func onClearPressed(_ sender: UIButton) {
    }
    
    @IBAction func onSubmitPressed(_ sender: UIButton) {
        createTrip()
    }
    
    @IBAction func seeLocationOnAMapPressed(_ sender: UIButton) {
    }
    
    func createTrip() {
        if nameOfEventTextField.text != nil {
            API.createTrip(eventDescription: nameOfEventTextField.text!, eventTime: datePicker.date, eventLocation: location) { (trip) in
                print(trip)
            }
        }
    }
}
