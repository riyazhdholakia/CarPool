//
//  MenuTableViewController.swift
//  CarPool
//
//  Created by Riyazh Dholakia on 11/14/17.
//  Copyright © 2017 Riyazh. All rights reserved.
//

import UIKit
import CarpoolKit
import MapKit

class MenuTableViewController: UITableViewController {
    
    @IBOutlet weak var maps: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 4 {
            let latitude: CLLocationDegrees = 37.2
            let longitude: CLLocationDegrees = 22.9
            let regionDistance: CLLocationDistance = 10000
            let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
            let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
            let options = [
                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
            ]
            let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = "Place Name"
            mapItem.openInMaps(launchOptions: options)
        }
    }
    
}
