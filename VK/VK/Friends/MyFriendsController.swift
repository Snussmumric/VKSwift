//
//  FriendsTableViewController.swift
//  VK
//
//  Created by Антон Васильченко on 20.06.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit

class MyFriendsController: UITableViewController {
    
    var friends: [User] = []
    var newFriends: [User] = []
    var friendDictionary = [String: [String]]()
    var friendSectionTitles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let friend1 = User(name: "Clare",
                           surname: "Smith",
                           city: "NY",
                           age: 22,
                           image: UIImage(named: "test"),
                           photos: [UIImage(named: "Clare"),
                                    UIImage(named: "Clare"),
                                    UIImage(named: "Clare"),
                                    UIImage(named: "Clare"),
                                    UIImage(named: "Clare"),
                                    UIImage(named: "Clare"),
                                    UIImage(named: "Clare"),
                                    UIImage(named: "Clare")])
        let friend2 = User(name: "Bob",
                           surname: "Willyams",
                           city: "TX",
                           age: 37,
                           image: UIImage(named: "Bob"),
                           photos: [UIImage(named: "Bob"),
                                    UIImage(named: "Bob"),
                                    UIImage(named: "Bob"),
                                    UIImage(named: "Bob")])
        let friend3 = User(name: "Alice",
                           surname: "Pachino",
                           city: "LA",
                           age: 22,
                           image: UIImage(named: "Alice"),
                           photos: [UIImage(named: "Alice"),
                                    UIImage(named: "Alice"),
                                    UIImage(named: "Alice"),
                                    UIImage(named: "Alice")])
        self.friends.append(friend3)
        self.friends.append(friend2)
        self.friends.append(friend1)
        
        
        for friend in friends {
            let friendKey = String(friend.surname.prefix(1))
            if var friendValues = friendDictionary[friendKey] {
                friendValues.append(friend.surname)
                friendDictionary[friendKey] = friendValues
            } else {
                friendDictionary[friendKey] = [friend.surname]

            }
        }
        
        friendSectionTitles = [String](friendDictionary.keys)
        friendSectionTitles = friendSectionTitles.sorted(by: {$0 < $1 })
        
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
        // #warning Incomplete implementation, return the number of rows
//        return friends.count
        
        let friendKey = friendSectionTitles[section]
        if let friendValues = friendDictionary[friendKey] {
            return friendValues.count
        }
        return 0
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        friendSectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyFriendsCell
        
        let currentFriend = self.friends[indexPath.row]
        let friendKey = friendSectionTitles[indexPath.section]
        if let newFriends = friendDictionary[friendKey] {
//            let currentFriend = newFriends[indexPath.row]
//            cell.friendName?.text = newFriends[indexPath.row]
            
        
            cell.friendImage?.image = currentFriend.image
        cell.friendName?.text = currentFriend.name + " " + currentFriend.surname
            
        }
        
        print(#function)
        print(friendDictionary[friendKey]!)

        cell.friendImage.layer.cornerRadius = cell.friendImage.frame.height/2
        cell.friendImage.clipsToBounds = true
        
        cell.containerView.layer.cornerRadius = cell.friendImage.frame.height/2
        cell.containerView.layer.shadowColor = UIColor.gray.cgColor
        cell.containerView.layer.shadowOffset = CGSize(width:0, height: 0)
        cell.containerView.layer.shadowRadius = 15.0
        cell.containerView.layer.shadowOpacity = 0.9
        
        return cell 
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return friendSectionTitles[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return friendSectionTitles
    }
    
}
