//
//  Profile.swift
//  VK
//
//  Created by Антон Васильченко on 16.09.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import Foundation

final class Profile: Decodable {
    
//    var name: String = ""
    var imageUrl50: String? = ""
    var imageUrl100: String? = ""
    var id: Int = 0
    var firstName: String? = ""
    var lastName: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case id
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
//        let firstName = try container.decodeIfPresent(String.self, forKey: .firstName) ?? ""
//        let lastName = try container.decodeIfPresent(String.self, forKey: .lastName) ?? ""
        
        self.lastName = try container.decodeIfPresent(String.self, forKey: .lastName) ?? ""
        self.firstName = try container.decodeIfPresent(String.self, forKey: .firstName) ?? ""
//        self.name = firstName + " " + lastName
        self.imageUrl50 = try container.decode(String.self, forKey: .photo50)
        self.imageUrl100 = try container.decode(String.self, forKey: .photo100)
        self.id = try container.decode(Int.self, forKey: .id)

    }

}
