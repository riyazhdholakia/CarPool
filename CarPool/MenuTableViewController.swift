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
import MessageUI

class MenuTableViewController: UITableViewController, MFMessageComposeViewControllerDelegate {
    
    @IBOutlet weak var inviteLabel: UILabel!
    @IBOutlet weak var logoutLabel: UILabel!
    
    let messageController = MFMessageComposeViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor.blue
        
        messageController.messageComposeDelegate = self
        
        API.fetchCurrentUser { (result) in
            switch result {
            case .success(let user):
                self.logoutLabel.text = "Logout \(user.name!)"
            case .failure(let error):
                self.logoutLabel.text = "Logout"
                print(error)
            }
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 3 {
            if MFMessageComposeViewController.canSendText() == true {
                let recipients: [String] = ["1500"]
                let messageController = MFMessageComposeViewController()
                messageController.messageComposeDelegate = self
                messageController.recipients = recipients
                messageController.body = "Would you like to join CarPool with me."
                self.present(messageController, animated: true, completion: nil)
            } else {
                //handle text messaging not available
            }
        }
        else if indexPath.section == 0 && indexPath.row == 4 {
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


