//
//  CreateTripViewController.swift
//  CarPool
//
//  Copyright © 2017 Riyazh. All rights reserved.
//

import UIKit
import CarpoolKit


class CreateTripViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTrip()
    }
    
    func createTrip() {
        API.createTrip(eventDescription: <#T##String#>, eventTime: <#T##Date#>, eventLocation: <#T##CLLocation#>) { (<#Trip#>) in
            <#code#>
        }
    }
}
