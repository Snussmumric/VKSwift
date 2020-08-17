//
//  Group.swift
//  VK
//
//  Created by Антон Васильченко on 21.06.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit
import RealmSwift


final class Groups: Object, Decodable {

    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var imageUrl: String? = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    // MARK: - Decodable
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case photo = "photo_50"
    }
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self .name = try container.decode(String.self, forKey: .name)
        self .id = try container.decode(Int.self, forKey: .id)
        self.imageUrl = try container.decode(String.self, forKey: .photo)
    }

}
