//
//  RootNavigationController.swift
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
        navigationController?.navigationBar.barTintColor = UIColor(red: 31/255, green: 39/255, blue: 144/255, alpha: 1)
        
        if API.isCurrentUserAnonymous == false {
            NotificationCenter.default.addObserver(forName: logMeinNotification, object: nil, queue: .main) { (_) in
                let loginVC = self.presentedViewController as? LoginViewController
                loginVC?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if API.isCurrentUserAnonymous == true {
            let loginVC = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController")
            present(loginVC, animated: animated, completion: nil)
        }
    }
    
}










