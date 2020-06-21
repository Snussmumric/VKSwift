//
//  Group.swift
//  VK
//
//  Created by Антон Васильченко on 21.06.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit

class Group {

    var name: String
    var image: UIImage?
    
    init() {
        self.name = "groupName"
        self.image = UIImage(systemName: "person.3")
    }
    
    init(name: String, image: UIImage?) {
        self.name = name
        self.image = image
    }

}
