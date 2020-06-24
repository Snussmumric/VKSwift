//
//  User.swift
//  VK
//
//  Created by Антон Васильченко on 21.06.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit

class User {

    var name: String
    var image: UIImage?
    var photos: [UIImage?]
    
    init() {
        self.name = "userName"
        self.image = UIImage(systemName: "person")
        self.photos = []
    }
    
    init(name: String, image: UIImage?, photos: [UIImage?]) {
        self.name = name
        self.image = image
        self.photos = photos
    }

}
