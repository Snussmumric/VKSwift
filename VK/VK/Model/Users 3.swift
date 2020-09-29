//
//  User.swift
//  VK
//
//  Created by Антон Васильченко on 21.06.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit
import RealmSwift

final class Users: Object, Decodable {
    
    @objc dynamic var name: String = ""
    @objc dynamic var imageUrl50: String? = ""
    @objc dynamic var imageUrl100: String? = ""
//    @objc dynamic var photos: [String] = []
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
//    var birthDate: String?
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    // MARK: - Decodable
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case id
//        case bdate = "bdate"
    }
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let firstName = try container.decode(String.self, forKey: .firstName)
        let lastName = try container.decode(String.self, forKey: .lastName)
        
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.name = firstName + " " + lastName
        self.imageUrl50 = try container.decode(String.self, forKey: .photo50)
        self.imageUrl100 = try container.decode(String.self, forKey: .photo100)
        self.id = try container.decode(Int.self, forKey: .id)
//        self.birthDate = try container.decode(String.self, forKey: .bdate)
    }

}
