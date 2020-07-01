//
//  AllGroupsController.swift
//  VK
//
//  Created by Антон Васильченко on 20.06.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit

class AllGroupsController: UITableViewController {
    
    var groups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let group1 = Group(name: "MacLovers", image: UIImage(named: "Apple"))
        let group2 = Group(name: "AndroidLovers", image: UIImage(named: "Android"))
        let group3 = Group(name: "WindowsLovers", image: UIImage(named: "Windows"))
        self.groups.append(group1)
        self.groups.append(group2)
        self.groups.append(group3)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AllGroupsCell
        let currentFriend = self.groups[indexPath.row]
        cell.allGroupsName.text = currentFriend.name
        cell.allGroupsImage.image = currentFriend.image
        
        return cell
    }
    
}
