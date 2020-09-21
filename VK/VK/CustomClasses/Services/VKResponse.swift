//
//  VKResponse.swift
//  VK
//
//  Created by Антон Васильченко on 03.08.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import Foundation

class VKResponse<T: Decodable>: Decodable {
    var count: Int
    var items: [T]
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case response
        case count
        case items
    }
    
    // MARK: - Decodable
    
    required init(from decoder: Decoder) throws {
        let topContainer = try decoder.container(keyedBy: CodingKeys.self)
        let container = try topContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        
        let items = try container.decode([T].self, forKey: .items)
        self.count = try container.decodeIfPresent(Int.self, forKey: .count) ?? items.count
        self.items = items
    }
}

class NewsResponse<T: Decodable>: VKResponse<T> {
    var profiles: [Profile]
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case response
//        case items
        case profiles
        case groups
    }
    
    // MARK: - Decodable
    
   required init(from decoder: Decoder) throws {
        let topContainer = try decoder.container(keyedBy: CodingKeys.self)
        let container = try topContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        
    let users = try container.decodeIfPresent([Profile].self, forKey: .profiles) ?? []
    let groups = try container.decodeIfPresent([Profile].self, forKey: .groups) ?? []
    self.profiles = users + groups
//        self.count = try container.decode(Int.self, forKey: .count)
//        self.items = try container.decode([T].self, forKey: .items)
    try super.init(from: decoder)
    }
}
  

