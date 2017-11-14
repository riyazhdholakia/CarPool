//
//  SearchFriendsViewController .swift
//  CarPool
//
//  Created by Naina  on 11/13/17.
//  Copyright © 2017 Riyazh. All rights reserved.
//

import UIKit
import CarpoolKit

class SearchFriendsViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchForFriends: UISearchBar!
    
    var friendsList: [User] = []
    var myFriends: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myFriendsShown()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        API.search(forUsersWithName: searchBar.text!) { (result) in
            switch result {
            case .success(let friends):
                self.friendsList = friends
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return myFriends.count
        } else {
            return friendsList.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchFriends", for: indexPath)
        if indexPath.section == 0 {
            cell.textLabel?.text = myFriends[indexPath.row].name
        } else if indexPath.section == 1 {
            cell.textLabel?.text = friendsList[indexPath.row].name
        }
        return cell
    }
    
    //todo maybe remove it from the observed list 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            API.add(friend: friendsList[indexPath.row])
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            API.remove(friend: myFriends[indexPath.row])
            myFriends.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "My friends (swipe to delete)"
        case 1:
            return "Add friends (tap to add)"
        default:
            return " "
        }
    }
    
}


