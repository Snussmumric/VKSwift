//
//  AllGroupsController.swift
//  VK
//
//  Created by Антон Васильченко on 20.06.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit

class AllGroupsController: UITableViewController, UISearchBarDelegate {
    
    lazy var loadImage = LoadImage()

    var groups: [Groups] = []
    lazy var service = VKService()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchGroups()
        
    }
    
    func searchGroups(_ text: String = "") {
        service.getData(.searchGroups(text: text), Groups.self, shouldCache: false) { [weak self] (groups: [Groups]) in
            self?.groups = groups
            self?.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AllGroupsCell
        cell.configure(group: groups[indexPath.row])
        
        loadImage.downloadImage(with: groups[indexPath.row].imageUrl ?? "") { (image) in
                        guard let image = image else { return }
                        cell.allGroupsImage.image = image
                    }
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchGroups(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.resignFirstResponder()
    }
    
}
