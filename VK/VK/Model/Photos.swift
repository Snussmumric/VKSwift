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
    
     @objc dynamic var imageURL: String?
    
    enum CodingKeys: String, CodingKey {
    case photo = "photo_604"
    }
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imageURL = try container.decode(String.self, forKey: .photo)
    }
}
