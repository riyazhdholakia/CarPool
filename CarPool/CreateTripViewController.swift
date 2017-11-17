//
//  CreateTripViewController.swift
//  CarPool
//
//  Copyright © 2017 Riyazh. All rights reserved.
//

import UIKit
import CarpoolKit
import MapKit

class CreateTripViewController: UIViewController {
    
    @IBOutlet weak var nameOfEventTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var childrenTextField: UITextField!
    @IBOutlet weak var seeLocationOnAMapButton: UIButton!
    @IBOutlet weak var locationEnteredTextField: UITextField!
    @IBOutlet weak var dropoffOrPickupSegmentedControll: UISegmentedControl!
    @IBOutlet weak var congratsLabel: UILabel!
    
    var location = CLLocation()
    let locationManager = CLLocationManager()
    var selectedDate = Date()
    var mapItems: [MKMapItem] = []
    var locationSelected: [MKMapItem] = []
    var selectedMapItem: MKMapItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.minimumDate = Date()
        locationManager.delegate = self
        navigationController?.navigationBar.barTintColor = UIColor(red: 31/255, green: 39/255, blue: 144/255, alpha: 1)
//        navigationController?.navigationBar.barTintColor = UIColor.blue
//        UITabBar.appearance().tintColor = UIColor.blue
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        datePicker.setDate(selectedDate, animated: true)
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    @IBAction func onLocationTextFieldPressed(_ sender: UITextField) {
        if locationEnteredTextField.text != nil {
            search(for: locationEnteredTextField.text!)
        }
    }
    
    func search(for query: String) {
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = query
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard let response = response else { return }
            print(response.mapItems)
            self.mapItems = response.mapItems
            self.performSegue(withIdentifier: "SegueToLocationsTableVC", sender: self)
        }
    }
    
    @IBAction func onDatePickerSelected(_ sender: UIDatePicker) {
        selectedDate = sender.date
    }
    
    @IBAction func onConfirmPressed(_ sender: UIBarButtonItem) {
        createTrip()
        congratsLabel.text = "Your trip has been created."
        nameOfEventTextField.text = ""
        datePicker.date = Date()
        childrenTextField.text = ""
        locationEnteredTextField.text = ""
    }
    
    @IBAction func seeLocationOnAMapPressed(_ sender: UIButton) {
        let mapVC = storyboard?.instantiateViewController(withIdentifier: "MapVC") as! MapViewController
        mapVC.selectedMapItem = selectedMapItem
    }
    
    @IBAction func onEventPressed(_ sender: UITextField) {
        congratsLabel.text = ""
    }
    
    func createTrip() {
        if nameOfEventTextField.text != nil {
            API.addChild(name: childrenTextField.text!, completion: { (result) in
                print(result)
            })
            
            if let selectedMapItem = selectedMapItem {
                
                let latitude = selectedMapItem.coordinate.latitude
                let longitude = selectedMapItem.coordinate.longitude
                let location = CLLocation(latitude: latitude, longitude: longitude)
                
                let formatter = DateFormatter()
                formatter.dateFormat = "EEEE"
                let formatterTime = DateFormatter()
                formatterTime.dateFormat = "h:mm a"
                
                var prettyStringForEvent = "On "
                prettyStringForEvent += formatter.string(from: datePicker.date)
                prettyStringForEvent += ", "
                prettyStringForEvent += nameOfEventTextField.text!
                prettyStringForEvent += " from "
                prettyStringForEvent += selectedMapItem.name!
                prettyStringForEvent += " by "
                prettyStringForEvent += formatterTime.string(from: datePicker.date)
                prettyStringForEvent += "."
                
                API.createTrip(eventDescription: prettyStringForEvent, eventTime: datePicker.date, eventLocation: location) { (result) in
                    print(result)
                    
                    switch result {
                    case .success(let createTrip):
                        API.addChild(name: self.childrenTextField.text!, completion: { (result) in
                            switch result {
                            case .success(let child):
                                print(child)
                            case .failure(let error):
                                print(error)
                            }
                        })
                        if self.dropoffOrPickupSegmentedControll.selectedSegmentIndex == 0 {
                            API.claimDropOff(trip: createTrip, completion: { (error) in
                                print(error) 
                            })
                        } else if self.dropoffOrPickupSegmentedControll.selectedSegmentIndex == 1 {
                            API.claimPickUp(trip: createTrip, completion: { (error) in
                                print(error)
                            })
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let locationsTableVC = segue.destination as? LocationsTableViewController {
            locationsTableVC.mapItems = mapItems
        }
        if let mapVC = segue.destination as? MapViewController {
            mapVC.selectedMapItem = selectedMapItem
        }
    }
    
    @IBAction func unwindFromLocationsTableVC(segue: UIStoryboardSegue) {
        selectedMapItem = (segue.source as! LocationsTableViewController).selectedMapItem
        locationEnteredTextField.text = selectedMapItem?.name
    }
    
}

extension CreateTripViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 10000, 10000)
        mapView.setRegion(coordinateRegion, animated: true)
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
