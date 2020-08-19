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
    var notificationToken: NotificationToken?
    var items: Results<Users>!
    
    @IBOutlet weak var friendSearcher: UISearchBar!
    
    var friends: [Users] = []
    var sections: [String] = []
    var filteredFriends: [Users] = [] {
        didSet {
            sections = Array(Set(filteredFriends
                .map{ $0.lastName.prefix(1).uppercased() }
            )).sorted()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewToRealm()
        loadFromNetwork()
        
        friendSearcher.delegate = self
        
    }
    
    
    func loadFromNetwork() {
        service.getData(.friends, Users.self)
    }
    
    private func bindViewToRealm () {
        items = realm.objects(Users.self)
        notificationToken = items.observe({ [weak self] (changes) in
            switch changes {
            case .initial(let items):
                self?.filteredFriends =  Array(  items)
                self?.tableView.reloadData()
            case .update:
                self?.filterFriends(text: self?.friendSearcher.text)
                self?.tableView.reloadData()
            case .error(let error):
                fatalError("\(error)")
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            let controller = segue.destination as? FriendViewController,
            let indexPath = tableView.indexPathForSelectedRow
        {
            //            let friend = friends[indexPath.row]
            let friend = items(indexPath.section)[indexPath.row]
            controller.photos = []
            controller.person = friend
            controller.title = friend.name
        }
    }
    
    private func items(_ section: Int) -> [Users] {
        return filteredFriends.filter {
            $0.lastName.hasPrefix(sections[section])
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items(section).count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyFriendsCell
        cell.configure(friend: items(indexPath.section)[indexPath.row])
        return cell
    }
    
    // MARK: - Search
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterFriends(text: searchText)
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
    private func filterFriends(text: String?) {
        if let text = text, text.isEmpty == false {
            filteredFriends = items.filter {
                $0.lastName.lowercased().contains(text.lowercased())
            }
        } else {
            filteredFriends = Array(items)
        }
    }
    
}
