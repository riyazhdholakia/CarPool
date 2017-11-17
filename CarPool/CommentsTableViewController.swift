//
//  CommentsTableViewController.swift
//  CarPool
//
//  Created by Riyazh Dholakia on 11/17/17.
//  Copyright © 2017 Riyazh. All rights reserved.
//

import UIKit
import CarpoolKit

class CommentsTableViewController: UITableViewController {
    
    @IBOutlet weak var commentsBelowLabel: UILabel!
    var trip: Trip!
    @IBOutlet weak var commentsTextView: UITextView!
    @IBOutlet weak var eventLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventLabel.text = trip.event.description
        
        API.observe(trip: trip, sender: self) { (result) in
            switch result {
            case .success(let trip):
                self.trip = trip
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func onSubmitPressed(_ sender: UIBarButtonItem) {
        if commentsTextView != nil {
            API.add(comment: commentsTextView.text, to: trip)
            commentsTextView.text = ""
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        header.backgroundView?.backgroundColor = UIColor.black
//        header.textLabel?.numberOfLines = 0
//        header.textLabel?.lineBreakMode = .byWordWrapping
//        header.textLabel?.frame.size.height = 100
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return trip.event.description
//    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if(indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor.lightGray
        } else {
            cell.backgroundColor = UIColor.white
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trip.comments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath)
        cell.textLabel?.text = trip.comments[indexPath.row].user.name
        cell.detailTextLabel?.text = trip.comments[indexPath.row].body
        return cell
    }
    
}
