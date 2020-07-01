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
    var surname: String
    var city: String
    var age: Int
    var image: UIImage?
    var photos: [UIImage?]
    
    init() {
        self.name = "userName"
        self.surname = "userSurname"
        self.city = "userCity"
        self.age = 99
        self.image = UIImage(systemName: "person")
        self.photos = []
    }
    
    init(name: String, surname: String, city: String, age: Int, image: UIImage?, photos: [UIImage?]) {
        self.name = name
        self.surname = surname
        self.city = city
        self.age = age
        self.image = image
        self.photos = photos
    }
    
}
