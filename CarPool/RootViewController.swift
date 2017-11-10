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
    
    @IBOutlet weak var allEventsOrMyEventsSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        API.observeTrips { (result) in
            switch result {
            case .success(let trips):
                self.trips = trips
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func onEventsSegmentedControllPressed(_ sender: UISegmentedControl) {
        switch allEventsOrMyEventsSegmentedControl.selectedSegmentIndex {
        case 0:
            API.observeTrips { (result) in
                switch result {
                case .success(let trips):
                    self.trips = trips
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        case 1:
            API.observeMyTrips(completion: { (result) in
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
        return trips.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RootVCEvents", for: indexPath)
        if allEventsOrMyEventsSegmentedControl.selectedSegmentIndex == 0 {
            if trips[indexPath.row].event.description == "" {
                cell.textLabel?.text = "* no event description *"
            } else {
                cell.textLabel?.text = trips[indexPath.row].event.description
            }
        } else if allEventsOrMyEventsSegmentedControl.selectedSegmentIndex == 1 {
            if trips[indexPath.row].event.description == "" {
                cell.textLabel?.text = "* no event description *"
            } else {
                cell.textLabel?.text = trips[indexPath.row].event.description
            }
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tripDetailVC = segue.destination as? TripDetailViewController {
            let indexPath = tableView.indexPathForSelectedRow
            tripDetailVC.trip = trips[(indexPath?.row)!]
        }
    }
    
    @IBAction func unwindFromCreateTripVC(segue: UIStoryboardSegue) {
    }
}

