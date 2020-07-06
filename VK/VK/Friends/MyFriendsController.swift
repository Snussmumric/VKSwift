//
//  FriendsTableViewController.swift
//  VK
//
//  Created by Антон Васильченко on 20.06.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit

class MyFriendsController: UITableViewController, UISearchBarDelegate {
    
    // MARK: - Main

    
    @IBOutlet weak var friendSearcher: UISearchBar!
    
    
//    var friends: [User] = []
    var sections: [String] = []
    var searchFriend = [User]()
    var searching = false
    
    var friends = User.friends
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        friends = friends.sorted (by: {$0.surname < $1.surname})
        
        sections = Array(
            Set(
                friends.map({
                    String($0.surname.prefix(1)).uppercased()
                })
            )
        )
        
        sections = sections.sorted(by: {$0 < $1})
        
        friendSearcher.delegate = self
        
    }
    
    // MARK: - Table

    
    func itemsInSections(_ section: Int) -> [User] {
        let letter = sections[section]
        return friends.filter {$0.surname.hasPrefix(letter)}
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is FriendViewController,
            let indexPath = self.tableView.indexPathForSelectedRow {
            let person = friends[indexPath.row]
            let destination = segue.destination as! FriendViewController
            destination.person = person
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searching {
           return searchFriend.count
        } else {
            return itemsInSections(section).count
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sections
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyFriendsCell
        
        if searching {
            let currentFriend = searchFriend[indexPath.row]
            cell.containerView.imageView.image = currentFriend.image
            cell.friendName?.text = currentFriend.name + " " + currentFriend.surname
        } else {
            let currentFriend = itemsInSections(indexPath.section)[indexPath.row]
            cell.containerView.imageView.image = currentFriend.image
            cell.friendName?.text = currentFriend.name + " " + currentFriend.surname + " " + "\(indexPath.section)" + "\(indexPath.row)"

        }
        
        cell.layer.backgroundColor = UIColor(rgb: 0x92D5F9).cgColor
        
        
        return cell 
    }
    
    // MARK: - Header

    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.layer.backgroundColor = UIColor(red: 0.146, green: 0.213, blue: 0.249, alpha: 0.75).cgColor
        
        let label = UILabel()
        label.frame = CGRect.init(x: 0, y: -10, width: headerView.frame.width, height: headerView.frame.height)
        label.text = sections[section]
        
        headerView.addSubview(label)
        
        return headerView
        
    }
    
    
    // MARK: - Search

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchFriend = friends.filter({($0.surname.prefix(searchText.count) == searchText) == true || ($0.name.prefix(searchText.count) == searchText) == true} )
        searching = true
        tableView.reloadData()
        
    }
    
    
}
