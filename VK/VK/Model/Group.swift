//
//  Group.swift
//  VK
//
//  Created by Антон Васильченко on 21.06.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit

struct Groups: Decodable {
    
    var name: String
    var imageUrl: String?
    
    // MARK: - Decodable
    
    enum CodingKeys: String, CodingKey {
        case name
        case photo = "photo_50"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self .name = try container.decode(String.self, forKey: .name)
        self.imageUrl = try container.decode(String.self, forKey: .photo)
    }

}
