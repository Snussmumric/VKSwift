//
//  NewsModel.swift
//  VK
//
//  Created by Антон Васильченко on 06.07.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit

class News: Decodable {
    
    var type: NewsItemType
    var author: Int = 0
    var date: Double = 0
    var text: String? = ""
    var commentsCount: Int = 0
    var likesCount: Int = 0
    var repostsCount: Int = 0
    var viewsCount: Int = 0
    var profile: Profile?
    
    enum CodingKeys: String, CodingKey {
        case type
        case author = "source_id"
        case date
        case text
        //        case attachments
        case comments
        case likes
        case reposts
        case views
        case count
    }

    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let typeString = try container.decode(String.self, forKey: .type)
        self.type = NewsItemType(rawValue: typeString) ?? .post
        self.author = try container.decode(Int.self, forKey: .author)
        self.date = try container.decode(Double.self, forKey: .date)
        self.text = try container.decodeIfPresent(String.self, forKey: .text) ?? ""
        
        if let nestedContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .likes) {
            self.likesCount = try nestedContainer.decode(Int.self,forKey: .count)
        }
        if let nestedContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .comments) {
            self.commentsCount = try nestedContainer.decode(Int.self,forKey: .count)
        }
        if let nestedContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .reposts) {
            self.repostsCount = try nestedContainer.decode(Int.self,forKey: .count)
        }
        if let nestedContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .views) {
            self.viewsCount = try nestedContainer.decode(Int.self,forKey: .count)
        }

        
    }
}

//enum NewsItemType: String {
//    case post
//    case photo = "wall_photo"
//}
