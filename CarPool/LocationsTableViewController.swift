//
//  LocationsTableViewController.swift
//  CarPool
//
//  Created by Naina  on 11/8/17.
//  Copyright © 2017 Riyazh. All rights reserved.
//

import UIKit
import MapKit

class LocationsTableViewController: UITableViewController {

    var mapItems: [MKMapItem] = []
    var selectedMapItem: MKMapItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red: 31/255, green: 39/255, blue: 144/255, alpha: 1)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mapItems.count
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        header.backgroundView?.backgroundColor = UIColor.black
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Tap on a location to select"
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor.gray
        } else {
            cell.backgroundColor = UIColor.white
            cell.textLabel?.textColor = UIColor.black
            cell.detailTextLabel?.textColor = UIColor.black
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Locations", for: indexPath)
        cell.textLabel?.text = mapItems[indexPath.row].name 
        cell.detailTextLabel?.text = mapItems[indexPath.row].placemark.title
        return cell 
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMapItem = mapItems[indexPath.row]
        performSegue(withIdentifier: "UnwindToCreatTripVC", sender: nil)
    }
    
}


