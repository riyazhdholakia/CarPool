//
//  EventDetailViewController.swift
//  CarPool
//
//  Created by Riyazh Dholakia on 11/6/17.
//  Copyright © 2017 Riyazh. All rights reserved.
//

import UIKit
import CarpoolKit
import MapKit

class TripsDetailViewController: UIViewController {
    
    var trip: Trip! //always bang after segue
    
    @IBOutlet weak var pickUpDriverNameLabel: UILabel!
    @IBOutlet weak var dropOffDriverNameLabel: UILabel!
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var dateForEventLabel: UILabel!
    @IBOutlet weak var claimDropoffButton: UIButton!
    @IBOutlet weak var claimPickupButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //title = trip.event.description
        
        API.observe(trip: trip, sender: self) { (result) in
            switch result {
            case .success(let trip):
                self.trip = trip
                self.showTripDetails()
            case .failure(let error):
                print(error)
            }
        }
        
        claimDropoffButton.layer.cornerRadius = 12
        claimPickupButton.layer.cornerRadius = 12
        navigationController?.navigationBar.barTintColor = UIColor(red: 31/255, green: 39/255, blue: 144/255, alpha: 1)    }
    
    @IBAction func onDirectionsPressed(_ sender: UIBarButtonItem) {
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
    
    func showTripDetails() {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        let formatterTime = DateFormatter()
        formatterTime.dateFormat = "h:mm a"
        pickUpDriverNameLabel.text = "Pick up driver name: " + (trip.pickUp?.driver.name ?? "Unclaimed")
        dropOffDriverNameLabel.text = "Drop off driver name: " + (trip.dropOff?.driver.name ?? "Unclaimed")
        dateForEventLabel.text = "Date: " + formatter.string(from: trip.event.time)
        timeLabel.text = "Time: " + formatterTime.string(from: trip.event.time)
        eventLabel.text = "Event: " + trip.event.description
        
        if trip.dropOff?.driver.name == nil {
            claimDropoffButton.backgroundColor = UIColor.red
        } else {
            claimDropoffButton.backgroundColor = UIColor.white
        }
        
        if trip.pickUp?.driver.name == nil {
            claimPickupButton.backgroundColor = UIColor.red
        } else {
            claimPickupButton.backgroundColor = UIColor.white
        }
    }
    
    @IBAction func onPickupClaimPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Alert", message: "Do you want to pickup?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Claim", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            self.claimPickupButton.backgroundColor = UIColor.white
            API.claimPickUp(trip: self.trip) { (error) in
                print(error)
                self.showTripDetails()
            }
        }))
        alert.addAction(UIAlertAction(title: "UnClaim", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            self.claimPickupButton.backgroundColor = UIColor.white
            API.unclaimPickUp(trip: self.trip, completion: { (error) in
                print(error)
                self.showTripDetails()
            })
        }))
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        showTripDetails()
    }
    
    @IBAction func onDropoffClaimPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Alert", message: "Do you want to dropoff?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Claim", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            self.claimDropoffButton.backgroundColor = UIColor.white
            API.claimDropOff(trip: self.trip) { (error) in
                print(error)
                self.showTripDetails()
            }
        }))
        alert.addAction(UIAlertAction(title: "UnClaim", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            self.claimPickupButton.backgroundColor = UIColor.white
            API.unclaimDropOff(trip: self.trip, completion: { (error) in
                print(error)
                self.showTripDetails()
            })
        }))
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        showTripDetails()
    }
    
}
