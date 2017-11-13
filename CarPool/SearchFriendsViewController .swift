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
    var myFriends: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myFriendsShown()
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
                        print(friends)
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
        if section == 0 {
            return myFriends.count
        } else {
            return friends.count
        }
    }
    
    //todo in to different sections
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchFriends", for: indexPath)
        if indexPath.section == 0 {
            cell.textLabel?.text = myFriends[indexPath.row].name
        } else if indexPath.section == 1 {
            cell.textLabel?.text = friends[indexPath.row].name
        }
        return cell
    }
    
    //todo the rest so they can delete friends or add
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
   override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "My friends"
        case 1:
            return "Add friends"
        default:
            return " "
        }
    }
    
}


