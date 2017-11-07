//
//  EventDetailViewController.swift
//  CarPool
//
//  Created by Riyazh Dholakia on 11/6/17.
//  Copyright © 2017 Riyazh. All rights reserved.
//

import UIKit
import CarpoolKit

class TripDetailViewController: UIViewController {
    
    var trip: Trip! //always bang after segue
    
    @IBOutlet weak var pickUpDriverNameLabel: UILabel!
    
    @IBOutlet weak var dropOffDriverNameLabel: UILabel!
    
    @IBOutlet weak var dropOffDriverPhoneLabel: UILabel!
    
    @IBOutlet weak var pickUpDriverPhoneLabel: UILabel!
    
    @IBOutlet weak var dateForEventLabel: UILabel!
    
    @IBOutlet weak var claimDropoffButton: UIButton!
    
    @IBOutlet weak var claimPickupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = trip.event.description
        
        showTripDetails()
    }
    
    
//    public static func claimLeg(leg: Leg, trip: Trip, completion: (Error?) -> Void) {
//        guard let index = fakeTrips.index(of: trip) else {
//            return completion(Error.noSuchTrip)
//        }
//
//        var trip = fakeTrips[index]
//
//    }
//
    func showTripDetails() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        pickUpDriverNameLabel.text = "Pick up driver name: " + (trip.pickUp.driver?.name ?? "Unclaimed")
        dropOffDriverNameLabel.text = "Drop off driver name: " + (trip.dropOff.driver?.name ?? "Unclaimed")
        dropOffDriverPhoneLabel.text = "Drop off driver phone#: " + "\(trip.dropOff.driver?.phone)"
        pickUpDriverPhoneLabel.text = "Pick up driver phone#: " + "\(trip.dropOff.driver?.phone)"
        dateForEventLabel.text = "Date/time: " + formatter.string(from: trip.event.time)
        if trip.dropOff.isClaimed == false {
            claimDropoffButton.backgroundColor = UIColor.red
        }
        if trip.pickUp.isClaimed == false {
            claimPickupButton.backgroundColor = UIColor.red
        }
    }
    
    @IBAction func onPickupClaimPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Alert", message: "My Alert for test", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Claim", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            print("you have pressed the ok button")
        }))
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
//        API.claimLeg(leg: Leg, trip: Trip,) { (<#API.Error?#>) in
//            <#code#>
//        }
    }
    
    
    @IBAction func onDropoffClaimPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Alert", message: "My Alert for test", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Claim", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            print("you have pressed the ok button")
        }))
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        API.claimLeg(leg: claimDropoffButton, trip: sender ) { (<#API.Error?#>) in
            <#code#>
        }
        
        
    }
    
    
    
    
}
