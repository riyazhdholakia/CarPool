//
//  SearchFriendsViewController.swift
//  CarPool
//
//  Created by Riyazh Dholakia on 11/14/17.
//  Copyright © 2017 Riyazh. All rights reserved.
//

import UIKit
import CarpoolKit

class SearchFriendsViewController: UITableViewController, UISearchBarDelegate {
    
    var friendsList: [User] = []
    
    @IBOutlet weak var friendsHasBeenAddedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        friendsHasBeenAddedLabel.text = ""
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
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        API.add(friend: friendsList[indexPath.row])
        friendsList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        friendsHasBeenAddedLabel.text = "Your friend's have been added."
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchFriends", for: indexPath)
        cell.textLabel?.text = friendsList[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Select friends by tapping on the name"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsList.count
    }
    
}
