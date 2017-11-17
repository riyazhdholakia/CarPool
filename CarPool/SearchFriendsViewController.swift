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
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 31/255, green: 39/255, blue: 144/255, alpha: 1)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor.gray
            cell.textLabel?.textColor = UIColor.black
        } else {
            cell.backgroundColor = UIColor(red: 31/255, green: 39/255, blue: 144/255, alpha: 1)
            cell.textLabel?.textColor = UIColor.white
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        header.backgroundView?.backgroundColor = UIColor.black
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
