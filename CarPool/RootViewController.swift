//
//  RootViewController.swift
//  CarPool
//
//  Created by Riyazh Dholakia on 11/6/17.
//  Copyright © 2017 Riyazh. All rights reserved.
//

import UIKit
import CarpoolKit

class RootViewController: UITableViewController {
    
    var trips: [Trip] = []
    var tripCalendar: [API.TripCalendar] = []
    
    @IBOutlet weak var allEventsOrMyEventsSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        API.observeMyTripCalendar(sender: self) { (result) in
            switch result {
            case .success(let trip):
                self.tripCalendar = [trip]
            case .failure(let error):
                print(error)
            }
        }
        
        
        API.observeMyTrips(sender: self, observer: { (result) in
            switch result {
            case .success(let trips):
                self.trips = trips
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        })
    }
    
    @IBAction func onEventsSegmentedControllPressed(_ sender: UISegmentedControl) {
        switch allEventsOrMyEventsSegmentedControl.selectedSegmentIndex {
        case 0:
            API.observeMyTrips(sender: self, observer: { (result) in
                switch result {
                case .success(let trips):
                    self.trips = trips
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            })
        case 1:
            API.observeTheTripsOfMyFriends(sender: self, observer: { (result) in
                switch result {
                case .success(let trips):
                    self.trips = trips
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            })
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return trips.count
        } else {
            return tripCalendar.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RootVCEvents", for: indexPath)
        if indexPath.section == 0 {
            if trips[indexPath.row].event.description == "" {
                cell.textLabel?.text = "* no event description *"
            } else {
                cell.textLabel?.text = trips[indexPath.row].event.description
            }
        } else {
            if trips[indexPath.row].event.description == "" {
                cell.textLabel?.text = "* no event description *"
            } else {
                
            }
        }
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "All my events"
        } else {
            return "7 day forecast of my events"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tripDetailVC = segue.destination as? TripsDetailViewController {
            let indexPath = tableView.indexPathForSelectedRow
            tripDetailVC.trip = trips[(indexPath?.row)!]
        }
    }
    
    @IBAction func unwindFromCreateTripVC(segue: UIStoryboardSegue) {
    }
}

