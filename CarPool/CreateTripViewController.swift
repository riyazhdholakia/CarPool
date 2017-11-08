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

class CreateTripViewController: UIViewController {
    
    @IBOutlet weak var nameOfEventTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var commentsTextField: UITextField!
    @IBOutlet weak var seeLocationOnAMapButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var locationEnteredTextField: UITextField!
    
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
        super.viewDidAppear(animated)
        
        datePicker.setDate(selectedDate, animated: true)
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func search(for query: String) {
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = query
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard let response = response else { return }
            print(response.mapItems)
            
            //self.mapView.addAnnotations(response.mapItems)
            
            //            for mapItem in response.mapItems{
            //                self.mapView.addAnnotation(mapItem.placemark)
            //            }
        }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mapVC = segue.destination as? MapViewController {
            
        }
        if let locationsTableVC = segue.destination as? LocationsTableViewController {
            
        }
    }
}

extension CreateTripViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 10000, 10000)
        mapView.setRegion(coordinateRegion, animated: true)
        
        if locationEnteredTextField.text != nil {
            search(for: locationEnteredTextField.text!)
        }
    }
}

extension CreateTripViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else { return }
        //mapView.showsUserLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}


