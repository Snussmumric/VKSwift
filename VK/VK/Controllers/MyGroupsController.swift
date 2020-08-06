//
//  MyGroupsController.swift
//  VK
//
//  Created by Антон Васильченко on 20.06.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit

class MyGroupsController: UITableViewController {
    
    var service = VKService()
    var groups: [Groups] = []
    var filteredGroups: [Groups] = []
    
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
        service.getGroups { [weak self] (groups) in
            self?.groups = groups
            self?.filteredGroups = groups
            self?.tableView.reloadData()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyGroupsCell
        cell.configure(group: filteredGroups[indexPath.row])

//        cell.myGroupImage.image = currentGroup.image
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } 
    }
    
}
