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
    
    var friends: [String] = []
//    var namesOfFriends = ["Josh,"Nik","Tina","Ross"] 
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        API.search(forUsersWithName: searchBar.text!) { (result) in
//                API.observeFriends(sender: self, observer: { (result) in
//                })
//                self.tableView.reloadData()
//        }
//        }
//
//
//    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
//        API.search(forUsersWithName: searchBar.text!) { (result) in
//            API.observeFriends(sender: self, observer: { (result) in
//            })
//            self.tableView.reloadData()
//        }
//
//
    
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return friends.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchFriends", for: indexPath)
            cell.textLabel?.text = friends[indexPath.row]
            return cell
        }
        
    }


