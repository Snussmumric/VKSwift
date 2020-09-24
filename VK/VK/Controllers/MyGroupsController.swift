//
//  MyGroupsController.swift
//  VK
//
//  Created by Антон Васильченко on 20.06.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit
import RealmSwift
import FirebaseDatabase

class MyGroupsController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    lazy var photoService = PhotoService.init(container: self.tableView)
    var service = VKGroupService()
    var groups: [Groups] = []
    var filteredGroups: [Groups] = []
    let session = Session.instance
    
    var notificationToken: NotificationToken?
    var items: Results<Groups>!
    lazy var database = Database.database()
    var firebaseDB: [FirebaseDB] = []
    lazy var ref: DatabaseReference = self.database.reference(withPath: "users")
    
    
    
    lazy var realm = try! Realm()
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        guard
            let allGroupsController = segue.source as? AllGroupsController,
            let indexPath = allGroupsController.tableView.indexPathForSelectedRow
            else {return}
        
        let group = allGroupsController.groups[indexPath.row]
        
        if !groups.contains(group){
            filteredGroups.append(group)
            let groupDB = FirebaseDB(groupID: group.id)
            ref
                .child(String(session.userId))
                .child("Groups")
                .child(String(groupDB.toDatabase()))
                .setValue([group.name, group.imageUrl])
            tableView.reloadData()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewToRealm()
        
        loadFromNetwork()
        searchBar.delegate = self
        
    }
    
    
    func loadFromNetwork() {
        service.get()
    }
    
    private func bindViewToRealm () {
        items = realm.objects(Groups.self)
        notificationToken = items.observe({ [weak self] (changes) in
            switch changes {
            case .initial(let items):
                self?.filteredGroups =  Array(items)
                self?.tableView.reloadData()
            case .update:
                self?.filteredGroups(text: self?.searchBar.text)
                self?.tableView.reloadData()
            case .error(let error):
                fatalError("\(error)")
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyGroupsCell
        cell.configure(group: filteredGroups[indexPath.row])
        cell.myGroupImage.image = photoService.photo(at: indexPath, url: filteredGroups[indexPath.row].imageUrl)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let group = filteredGroups[indexPath.row]
            filteredGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            let groupDB = FirebaseDB(groupID: group.id)

            ref
            .child(String(session.userId))
            .child("Groups")
            .child(String(groupDB.toDatabase()))
            .removeValue()
        }
    }
    
    // MARK: - Search
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredGroups(text: searchText)
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
    private func filteredGroups(text: String?) {
        if let text = text, text.isEmpty == false {
            filteredGroups = items.filter {
                $0.name.lowercased().contains(text.lowercased())
            }
        } else {
            filteredGroups = Array(items)
        }
    }
    
    
}
