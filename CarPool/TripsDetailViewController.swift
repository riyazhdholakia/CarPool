//
//  EventDetailViewController.swift
//  CarPool
//
//  Created by Riyazh Dholakia on 11/6/17.
//  Copyright © 2017 Riyazh. All rights reserved.
//

import UIKit
import CarpoolKit

class TripsDetailViewController: UIViewController {
    
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
    
    func showTripDetails() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, YYYY h:mm a"
        pickUpDriverNameLabel.text = "Pick up driver name: " + (trip.pickUp?.driver.name ?? "Unclaimed")
        dropOffDriverNameLabel.text = "Drop off driver name: " + (trip.dropOff?.driver.name ?? "Unclaimed")
        //        dropOffDriverPhoneLabel.text = "Drop off driver phone#: " + "\(trip.dropOff?.driver?.phone)"
        //        pickUpDriverPhoneLabel.text = "Pick up driver phone#: " + "\(trip.dropOff?.driver?.phone)"
        dateForEventLabel.text = "Date/time: " + formatter.string(from: trip.event.time)
        
        if pickUpDriverNameLabel.text == "Pick up driver name: Unclaimed" {
            claimPickupButton.backgroundColor = UIColor.red
        } else {
            claimPickupButton.backgroundColor = UIColor.white
        }
        
        if dropOffDriverNameLabel.text == "Drop off driver name: Unclaimed" {
            claimDropoffButton.backgroundColor = UIColor.red
        } else {
            claimDropoffButton.backgroundColor = UIColor.white
        }
    }
    
    @IBAction func onPickupClaimPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Alert", message: "Do you want to pickup?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Claim", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            self.claimPickupButton.backgroundColor = UIColor.white
            API.claimPickUp(trip: self.trip) { (error) in
                print(error)
            }
        }))
        alert.addAction(UIAlertAction(title: "UnClaim", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            self.claimPickupButton.backgroundColor = UIColor.white
            API.unclaimPickUp(trip: self.trip, completion: { (error) in
                print(error)
            })
        }))
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func onDropoffClaimPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Alert", message: "Do you want to dropoff?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Claim", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            self.claimDropoffButton.backgroundColor = UIColor.white
            API.claimDropOff(trip: self.trip) { (error) in
                print(error) 
            }
        }))
        alert.addAction(UIAlertAction(title: "UnClaim", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            self.claimPickupButton.backgroundColor = UIColor.white
            API.unclaimDropOff(trip: self.trip, completion: { (error) in
                print(error)
            })
        }))
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}