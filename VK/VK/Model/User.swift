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
    
    
    static let friends: [User] = [
        User(name: "Clare",
        surname: "Willyams",
        city: "NY",
        age: 22,
        image: UIImage(named: "test"),
        photos: [UIImage(named: "Clare"),
                 UIImage(named: "Clare"),
                 UIImage(named: "Clare"),
                 UIImage(named: "Clare"),
                 UIImage(named: "Clare"),
                 UIImage(named: "Clare"),
                 UIImage(named: "Clare"),
                 UIImage(named: "Clare")]),
        User(name: "Bob",
        surname: "Smith",
        city: "TX",
        age: 37,
        image: UIImage(named: "Bob"),
        photos: [UIImage(named: "Bob"),
                 UIImage(named: "Bob"),
                 UIImage(named: "Bob"),
                 UIImage(named: "Bob")]),
        User(name: "Alice",
        surname: "Pachino",
        city: "LA",
        age: 22,
        image: UIImage(named: "Alice"),
        photos: [UIImage(named: "Alice"),
                 UIImage(named: "Alice"),
                 UIImage(named: "Alice"),
                 UIImage(named: "Alice")]),
        User(name: "Alice",
        surname: "Pachinello",
        city: "LA",
        age: 22,
        image: UIImage(named: "Alice"),
        photos: [UIImage(named: "Alice"),
                 UIImage(named: "Alice"),
                 UIImage(named: "Alice"),
                 UIImage(named: "Alice")])    ]
}
