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
    
    //var trip: [Trip] = []
    var trip: Trip! //always bang after segue
    
    @IBOutlet weak var pickUpDriverNameLabel: UILabel!
    
    @IBOutlet weak var dropOffDriverNameLabel: UILabel!
    
    @IBOutlet weak var dropOffDriverPhoneLabel: UILabel!
    
    @IBOutlet weak var pickUpDriverPhoneLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        API.fetchTripsOnce { (trips) in
        //            self.trips = trips
        //        }
        
        pickUpDriverNameLabel.text = "Pick up driver name: " + (trip.pickUp.driver?.name)!
        dropOffDriverNameLabel.text = "Drop off driver name: " + (trip.dropOff.driver?.name)!
        dropOffDriverPhoneLabel.text = "Drop off driver phone#: " + "\(trip.dropOff.driver?.phone)!"
        pickUpDriverPhoneLabel.text = "Pick up driver phone#: " + "\(trip.dropOff.driver?.phone)!"
        
    }
    
    @IBAction func onLegClaimPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Alert", message: "My Alert for test", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Claim", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            print("you have pressed the ok button")
        }))
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
