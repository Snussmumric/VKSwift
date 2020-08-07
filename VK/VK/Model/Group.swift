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
    
    @objc dynamic var name: String = ""
    @objc dynamic var imageUrl: String?
    
    // MARK: - Decodable
    
    enum CodingKeys: String, CodingKey {
        case name
        case photo = "photo_50"
    }
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self .name = try container.decode(String.self, forKey: .name)
        self.imageUrl = try container.decode(String.self, forKey: .photo)
    }

}
