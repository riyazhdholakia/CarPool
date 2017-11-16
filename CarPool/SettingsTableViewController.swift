//
//  SettingsTableViewController.swift
//  CarPool
//
//  Created by Naina  on 11/9/17.
//  Copyright © 2017 Riyazh. All rights reserved.
//

import UIKit
import CarpoolKit

class SettingsTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red: 33/255, green: 58/255, blue: 161/255, alpha: 1)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0, indexPath.row == 0 {
            API.fetchCurrentUser().value?.name 
            let loginVC =    self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController")
            self.present(loginVC, animated: true, completion: nil)
        }
    }
}
