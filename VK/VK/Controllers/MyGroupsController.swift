//
//  MyGroupsController.swift
//  VK
//
//  Created by Антон Васильченко on 20.06.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit
import RealmSwift

class MyGroupsController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var service = VKService()
    var groups: [Groups] = []
    var filteredGroups: [Groups] = []
    
    var notificationToken: NotificationToken?
    var items: Results<Groups>!
    
    lazy var realm = try! Realm()
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if segue.identifier == "addGroup" {
            let allGroupsController = segue.source as! AllGroupsController
            
            if let indexPath = allGroupsController.tableView.indexPathForSelectedRow {
                let group = allGroupsController.groups[indexPath.row]
                groups.append(group)
                tableView.reloadData()
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewToRealm()

        loadFromNetwork()
        searchBar.delegate = self
        
    }
    
    
    func loadFromNetwork() {
        service.getData(.groups, Groups.self)
    }
    
    private func bindViewToRealm () {
        items = realm.objects(Groups.self)
        notificationToken = items.observe({ [weak self] (changes) in
            switch changes {
            case .initial(let items):
                self?.filteredGroups =  Array(  items)
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
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            filteredGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
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
