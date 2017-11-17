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
    var tripCalendar: API.TripCalendar?
    
    @IBOutlet weak var allEventsOrMyEventsSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 31/255, green: 39/255, blue: 144/255, alpha: 1)
        
        API.observeMyTripCalendar(sender: self) { (result) in
            switch result {
            case .success(let trip):
                self.tripCalendar = trip
                self.tableView.reloadData()
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
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        header.backgroundView?.backgroundColor = UIColor.black
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if(indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor.lightGray
        } else {
            cell.backgroundColor = UIColor.white
        }
    }
    
    @IBAction func onEventsSegmentedControllPressed(_ sender: UISegmentedControl) {
        switch allEventsOrMyEventsSegmentedControl.selectedSegmentIndex {
        case 0:
            API.observeMyTripCalendar(sender: self) { (result) in
                switch result {
                case .success(let tripCalendar):
                    self.tripCalendar = tripCalendar
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        case 1:
            API.observeMyTrips(sender: self, observer: { (result) in
                switch result {
                case .success(let trips):
                    self.trips = trips
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            })
        case 2:
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        var sectionsNum: Int
        if allEventsOrMyEventsSegmentedControl.selectedSegmentIndex == 0 {
            sectionsNum = 7
        } else if allEventsOrMyEventsSegmentedControl.selectedSegmentIndex == 1 {
            sectionsNum = 1
        } else {
            sectionsNum = 1
        }
        return sectionsNum
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return tripCalendar?.dailySchedule(forWeekdayOffsetFromToday: section).trips.count ?? 0
        var count: Int
        if allEventsOrMyEventsSegmentedControl.selectedSegmentIndex == 0 {
            count = tripCalendar?.dailySchedule(forWeekdayOffsetFromToday: section).trips.count ?? 0
        } else if allEventsOrMyEventsSegmentedControl.selectedSegmentIndex == 1 {
            count = trips.count
        } else {
            count = trips.count
        }
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RootVCEvents", for: indexPath) as! RootVCEventsCell
        
        if allEventsOrMyEventsSegmentedControl.selectedSegmentIndex == 0 {
            let dailySchedule = tripCalendar?.dailySchedule(forWeekdayOffsetFromToday: indexPath.section)
            let trip = dailySchedule?.trips[indexPath.row]
            cell.eventLabel.text = trip?.event.description
            
            if trip?.dropOff?.driver.name == nil {
                cell.thumbsImage.image = #imageLiteral(resourceName: "thumbsdownred")
            } else if trip?.pickUp?.driver.name == nil {
                cell.thumbsImage.image = #imageLiteral(resourceName: "thumbsdownred")
            } else {
                cell.thumbsImage.image = #imageLiteral(resourceName: "greenthumbsup")
            }
            
        } else if allEventsOrMyEventsSegmentedControl.selectedSegmentIndex == 1 {
            cell.eventLabel.text = trips[indexPath.row].event.description
            
            if trips[indexPath.row].dropOff?.driver.name == nil {
                cell.thumbsImage.image = #imageLiteral(resourceName: "thumbsdownred")
            } else if trips[indexPath.row].pickUp?.driver.name == nil {
                cell.thumbsImage.image = #imageLiteral(resourceName: "thumbsdownred")
            } else {
                cell.thumbsImage.image = #imageLiteral(resourceName: "greenthumbsup")
            }
        } else {
            cell.eventLabel.text = trips[indexPath.row].event.description
            
            if trips[indexPath.row].dropOff?.driver.name == nil {
                cell.thumbsImage.image = #imageLiteral(resourceName: "thumbsdownred")
            } else if trips[indexPath.row].pickUp?.driver.name == nil {
                cell.thumbsImage.image = #imageLiteral(resourceName: "thumbsdownred")
            } else {
                cell.thumbsImage.image = #imageLiteral(resourceName: "greenthumbsup")
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var date: String?
        if allEventsOrMyEventsSegmentedControl.selectedSegmentIndex == 0 {
            date = tripCalendar?.dailySchedule(forWeekdayOffsetFromToday: section).prettyName
        }
        return date
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

class RootVCEventsCell: UITableViewCell {
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var thumbsImage: UIImageView!
}
