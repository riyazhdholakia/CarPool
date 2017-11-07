//
//  EventDetailViewController.swift
//  CarPool
//
//  Created by Riyazh Dholakia on 11/6/17.
//  Copyright © 2017 Riyazh. All rights reserved.
//

import UIKit
import CarpoolKit

class EventDetailViewController: UIViewController {
    
    //var trip: [Trip] = []
    var trip: Trip! //always bang after segue
    
    @IBOutlet weak var pickUpDriverLabel: UILabel!
    
    @IBOutlet weak var dropOffDriverLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        API.fetchTripsOnce { (trips) in
//            self.trips = trips
//        }
    
        pickUpDriverLabel.text = trip.pickUp.driver?.name
        dropOffDriverLabel.text = trip.dropOff.driver?.name
    }
    
    
}
