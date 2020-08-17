//
//  Photos.swift
//  VK
//
//  Created by Антон Васильченко on 05.08.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import Foundation

struct Photos: Decodable {
    
    var imageURL: String?
    
    enum CodingKeys: String, CodingKey {
    case photo = "photo_604"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imageURL = try container.decode(String.self, forKey: .photo)
    }
}
