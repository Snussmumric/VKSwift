//
//  NewsResponse.swift
//  VK
//
//  Created by Антон Васильченко on 10.09.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import Foundation

struct NewsResponse<T: News>: Decodable {
    var items: [T]
//    var profiles: [Users]
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case response
        case items
        case profiles
        case groups
    }
    
    // MARK: - Decodable
    
    init(from decoder: Decoder) throws {
        let topContainer = try decoder.container(keyedBy: CodingKeys.self)
        let container = try topContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        
//        self.count = try container.decode(Int.self, forKey: .count)
        self.items = try container.decode([T].self, forKey: .items)
    }
}
  
