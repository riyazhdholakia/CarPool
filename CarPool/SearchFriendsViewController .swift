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
    
    var friends: [User] = []
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        API.search(forUsersWithName: searchBar.text!) { (result) in
            switch result {
            case .success(_):
                API.observeFriends(sender: self, observer: { (result) in
                    switch result {
                    case .success(let friends):
                        self.friends = friends
                        self.tableView.reloadData()
                    case .failure(let error):
                        print(error)
                    }
                })
            case .failure(let error):
                print(error)
            }
            self.tableView.reloadData() 
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchFriends", for: indexPath)
        cell.textLabel?.text = friends[indexPath.row].name
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//
//    }
//
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//    }
    
}


