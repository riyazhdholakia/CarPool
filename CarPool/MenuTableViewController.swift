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
        
       navigationController?.navigationBar.barTintColor = UIColor(red: 31/255, green: 39/255, blue: 144/255, alpha: 1)
        
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
        
        switch (result) {
        case .cancelled:
            print("Message was cancelled")
        case .sent:
            print("Message was sent")
        case .failed:
            print("Message failed")
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 2 {
            if MFMessageComposeViewController.canSendText() == true {
                let recipients: [String] = ["1500"]
                //let messageController = MFMessageComposeViewController()
                //messageController.messageComposeDelegate = self
                messageController.recipients = recipients
                messageController.body = "Would you like to join CarPool with me."
                self.present(messageController, animated: true, completion: nil)
            } else {
                //handle text messaging not available
            }
            
        }
    }
}


