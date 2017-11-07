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
    
    @IBOutlet weak var dateForEventLabel: UILabel!
    
    @IBOutlet weak var label2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showTripDetails()
    }
    
    func showTripDetails() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        pickUpDriverNameLabel.text = "Pick up driver name: " + (trip.pickUp.driver?.name ?? "Unclaimed")
        dropOffDriverNameLabel.text = "Drop off driver name: " + (trip.dropOff.driver?.name ?? "Unclaimed")
        dropOffDriverPhoneLabel.text = "Drop off driver phone#: " + "\(trip.dropOff.driver?.phone)"
        pickUpDriverPhoneLabel.text = "Pick up driver phone#: " + "\(trip.dropOff.driver?.phone)"
        dateForEventLabel.text = "Date/time: " + formatter.string(from: trip.event.time)
    }
    
}
