//
//  SearchFriendsViewController .swift
//  CarPool
//
//  Created by Naina  on 11/13/17.
//  Copyright © 2017 Riyazh. All rights reserved.
//

import UIKit
import CarpoolKit

class FriendsViewController: UITableViewController {
    
    var myFriends: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myFriendsShown()
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 31/255, green: 39/255, blue: 144/255, alpha: 1)
    }
    
        override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            if(indexPath.row % 2 == 0) {
                cell.backgroundColor = UIColor.gray
                cell.textLabel?.textColor = UIColor.black
            } else {
                cell.backgroundColor = UIColor.white
                cell.textLabel?.textColor = UIColor.black
            }
        }
    
    func myFriendsShown() {
        API.observeFriends(sender: self) { (result) in
            switch result {
            case .success(let myFriends):
                self.myFriends = myFriends
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        header.backgroundView?.backgroundColor = UIColor.black
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFriends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyFriends", for: indexPath)
//        var numbers = myFriends
//        (append(String(myFriends.count + 1) + ". "))
        cell.textLabel?.text = myFriends[indexPath.row].name!
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            API.remove(friend: myFriends[indexPath.row])
            myFriends.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Swipe to delete"
    }
    
}


