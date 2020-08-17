//
//  AllGroupsController.swift
//  VK
//
//  Created by Антон Васильченко on 20.06.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit

class AllGroupsController: UITableViewController {
    
    var groups: [Groups] = []
    lazy var service = VKService()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.getGroups { [weak self] (groups) in
            self?.groups = groups
//            self?.filteredFriends = friends
            self?.tableView.reloadData()

            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AllGroupsCell
        cell.configure(group: groups[indexPath.row])
        return cell
    }
    
}
