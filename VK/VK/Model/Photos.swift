//
//  Photos.swift
//  VK
//
//  Created by Антон Васильченко on 05.08.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import Foundation
import RealmSwift

final class Photos: Object, Decodable {
    
    @objc dynamic var imageURL: String? = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var ownerID: Int = 0
    @objc dynamic var albumID: Int = 0


    
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case photo = "photo_604"
        case ownerID = "owner_id"
        case albumID = "album_id"
    }
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imageURL = try container.decode(String.self, forKey: .photo)
        self.id = try container.decode(Int.self, forKey: .id)
        self.ownerID = try container.decode(Int.self, forKey: .ownerID)
        self.albumID = try container.decode(Int.self, forKey: .albumID)


        
        
    }
}
