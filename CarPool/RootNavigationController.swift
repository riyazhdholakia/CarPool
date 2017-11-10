//
//  RootTabBarController.swift
//  CarPool
//
//  Created by Naina  on 11/9/17.
//  Copyright © 2017 Riyazh. All rights reserved.
//

import UIKit
import CarpoolKit

let logMeinNotification = Notification.Name("LogMeInDidCompleteNotification")

class RootNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: logMeinNotification, object: nil, queue: .main) { (_) in
            if let loginVC = self.presentedViewController as? LoginViewController {
                loginVC.dismiss(animated: true, completion: nil) 
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if API.isCurrentUserAnonymous { 
            let loginVC = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController")
            present(loginVC, animated: animated, completion: nil)
        }
    }
    
}










