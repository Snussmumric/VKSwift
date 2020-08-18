//
//  FriendsTableViewController.swift
//  VK
//
//  Created by Антон Васильченко on 20.06.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit
import RealmSwift

class MyFriendsController: UITableViewController, UISearchBarDelegate {
    
    // MARK: - Main
    
    lazy var service = VKService()
    lazy var realm = try! Realm()
    
    
    
    @IBOutlet weak var friendSearcher: UISearchBar!
    
    
    var filteredFriends: [Users] = []
    var friends: [Users] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFromCache()
        loadFromNetwork()
        
        friendSearcher.delegate = self
        
    }
    
    func loadFromCache() {
        let object = realm.objects(Users.self)
        
        friends = Array(object)
        filteredFriends = friends
        tableView?.reloadData()
    }
    
    func loadFromNetwork() {
        service.getData(.friends, Users.self) { [weak self] _ in
            self?.loadFromCache()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            let controller = segue.destination as? FriendViewController,
            let indexPath = tableView.indexPathForSelectedRow
        {
            let friend = friends[indexPath.row]
            controller.photos = []
            controller.person = friend
            controller.title = friend.name
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFriends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyFriendsCell
        cell.configure(friend: filteredFriends[indexPath.row])
        return cell
    }
    
    // MARK: - Search
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredFriends = friends
        } else {
            filteredFriends = friends.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
}
